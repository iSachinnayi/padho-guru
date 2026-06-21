import 'dart:io';
import 'package:genkit/genkit.dart';
import 'package:genkit_openai/genkit_openai.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:genkit_shelf/genkit_shelf.dart';
import 'package:schemantic/schemantic.dart';
import 'package:dotenv/dotenv.dart' show load;

part 'server.g.dart';

void main() async {
  // Load environment variables
  load();

  final apiKey = Platform.environment['OPENAI_API_KEY'];
  if (apiKey == null) {
    print('❌ OPENAI_API_KEY not set. Create a .env file or set environment variable.');
    exit(1);
  }

  // Initialize Genkit with OpenAI plugin
  final ai = Genkit(plugins: [
    openAI(apiKey: apiKey),
  ]);

  // ─── Define Schemas ──────────────────────────────────────

  @Schema()
  abstract class $QuestionInput {
    @Field(description: 'The question text in Hindi or English')
    String get text;

    @Field(description: 'Subject (e.g., Science, Maths)')
    String? get subject;

    @Field(description: 'Class (e.g., Class 10)')
    String? get studentClass;
  }

  @Schema()
  abstract class $Step {
    @Field(description: 'Step number')
    int get stepNumber;

    @Field(description: 'Step explanation in Hindi')
    String get explanation;
  }

  @Schema()
  abstract class $AnswerOutput {
    @Field(description: 'Full answer in Hindi')
    String get answer;

    @Field(description: 'Step-by-step breakdown')
    List<$Step> get steps;

    @Field(description: 'Related topics for further study')
    List<String> get relatedTopics;

    @Field(description: 'Subject of the question')
    String? get subject;

    @Field(description: 'Chapter name if identifiable')
    String? get chapter;
  }

  // ─── Define Flow: Ask Question ───────────────────────────

  final askFlow = ai.defineFlow(
    name: 'askQuestion',
    inputSchema: QuestionInput.$schema,
    outputSchema: AnswerOutput.$schema,
    fn: (QuestionInput input, _) async {
      final response = await ai.generate(
        model: openAI.model('gpt-5.4-mini'),
        config: OpenAIOptions(
          temperature: 0.7,
          systemInstruction: '''You are पढ़ो गुरु, an expert NCERT tutor for Indian students.
          Rules:
          1. Answer in HINDI only (simple, clear language)
          2. Provide step-by-step explanation
          3. Use NCERT curriculum context
          4. Give real-life examples where possible
          5. Be encouraging and patient
          6. If the question is about Science/Maths, include formulas where relevant
          Subject: ${input.subject ?? 'General'}
          Class: ${input.studentClass ?? 'Not specified'}''',
        ),
        prompt: input.text,
        outputSchema: AnswerOutput.$schema,
      );

      if (response.output == null) {
        throw Exception('Failed to generate answer');
      }

      return response.output!;
    },
  );

  // ─── Define Flow: Health Check ───────────────────────────

  final healthFlow = ai.defineFlow(
    name: 'health',
    fn: (String _, __) async => 'OK',
    inputSchema: .string(),
    outputSchema: .string(),
  );

  // ─── HTTP Server Setup (Shelf) ───────────────────────────

  final router = Router();

  // Mount flows as HTTP endpoints
  router.post('/ask', shelfHandler(askFlow));
  router.get('/health', shelfHandler(healthFlow));

  // CORS middleware
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_corsMiddleware())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '3400');
  final server = await io.serve(handler, InternetAddress.anyIPv4, port);

  print('✅ पढ़ो गुरु AI Server running on http://localhost:$port');
  print('   POST /ask  → Ask a question');
  print('   GET  /health → Health check');
}

// ─── CORS Middleware ────────────────────────────────────────
Middleware _corsMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        });
      }

      final response = await innerHandler(request);
      return response.change(headers: {
        'Access-Control-Allow-Origin': '*',
      });
    };
  };
}
