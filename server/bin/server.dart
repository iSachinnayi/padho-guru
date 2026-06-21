import 'dart:convert';
import 'dart:io';
import 'package:genkit/genkit.dart';
import 'package:genkit_openai/genkit_openai.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:genkit_shelf/genkit_shelf.dart';

void main() async {
  // Load API key from .env file
  String? apiKey = Platform.environment['OPENAI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    final envFile = File('.env');
    if (envFile.existsSync()) {
      final lines = envFile.readAsLinesSync();
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('OPENAI_API_KEY=')) {
          apiKey = trimmed.substring('OPENAI_API_KEY='.length);
          break;
        }
      }
    }
  }
  if (apiKey == null || apiKey.isEmpty) {
    print('❌ OPENAI_API_KEY not set. Create a .env file.');
    exit(1);
  }

  // Initialize Genkit with OpenAI plugin
  final ai = Genkit(plugins: [openAI(apiKey: apiKey)]);

  // ─── Flow: Health Check ─────────────────────────────────
  final healthFlow = ai.defineFlow(
    name: 'health',
    fn: (String _, __) async => 'OK',
  );

  // ─── Flow: Ask Question ─────────────────────────────────
  final askFlow = ai.defineFlow(
    name: 'askQuestion',
    fn: (String input, _) async {
      final inputMap = jsonDecode(input) as Map<String, dynamic>;
      final questionText = inputMap['text'] as String? ?? '';
      final subject = inputMap['subject'] as String? ?? '';
      final studentClass = inputMap['class'] as String? ?? '';

      final response = await ai.generate(
        model: openAI.model('gpt-5.4-mini'),
        config: OpenAIOptions(temperature: 0.7),
        prompt: questionText,
      );

      if (response.text == null) {
        return 'क्षमा करें, जवाब नहीं मिल सका। कृपया पुनः प्रयास करें।';
      }
      return response.text!;
    },
  );

  // ─── HTTP Server Setup ──────────────────────────────────
  final router = Router();

  // GET /health — Simple health check (plain Shelf handler)
  router.get('/health', (Request request) async {
    return Response.ok(
      '{"status":"OK"}',
      headers: {'Content-Type': 'application/json'},
    );
  });

  // POST /ask — Ask a question via Genkit flow
  router.post('/ask', shelfHandler(askFlow));

  // CORS middleware
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_corsMiddleware())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '3400');
  final server = await io.serve(handler, InternetAddress.anyIPv4, port);

  print('───────────────────────────────');
  print('  ✅ पढ़ो गुरु AI Server');
  print('  Running on http://localhost:$port');
  print('  POST /ask  → Ask a question');
  print('  GET  /health → Health check');
  print('───────────────────────────────');
}

// ─── CORS Middleware ────────────────────────────────────────
Middleware _corsMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          },
        );
      }

      final response = await innerHandler(request);
      return response.change(headers: {'Access-Control-Allow-Origin': '*'});
    };
  };
}
