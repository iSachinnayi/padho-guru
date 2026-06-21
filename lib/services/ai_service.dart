import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';
import '../models/answer_model.dart';

/// पढ़ो गुरु — AI Service
/// Calls Genkit server on Cloud Run (or local for dev).
class AIService {
  // Change this URL based on environment:
  // - Local: 'http://localhost:3400'
  // - Cloud Run: 'https://padho-guru-server-xxxxx-uc.a.run.app'
  static const String _baseUrl = 'http://localhost:3400';

  // ─── Ask Question ─────────────────────────────────────────
  Future<AnswerModel> askQuestion(QuestionModel question) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/ask'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'data': {
            'text': question.text,
            'subject': question.subject ?? '',
            'class': question.studentClass ?? '',
          },
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final result = body['result'] as Map<String, dynamic>;

        return AnswerModel(
          id: question.id,
          questionText: question.text,
          answer: result['answer'] ?? '',
          steps: (result['steps'] as List<dynamic>?)
                  ?.map((s) => s is Map<String, dynamic>
                      ? '${s['stepNumber']}. ${s['explanation']}'
                      : s.toString())
                  .toList() ??
              [],
          relatedTopics: (result['relatedTopics'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
          subject: result['subject'],
          chapter: result['chapter'],
          language: 'hi',
        );
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // If server is not available, return mock data for development
      return _getMockAnswer(question);
    }
  }

  // ─── Stream Answer (SSE for future use) ──────────────────
  Stream<String> streamAnswer(QuestionModel question) async* {
    // For now, simulate streaming with mock data
    // TODO: Implement real SSE streaming from Genkit server
    final mockAnswer = AnswerModel.sample.answer;
    final words = mockAnswer.split(' ');

    for (final word in words) {
      await Future.delayed(const Duration(milliseconds: 60));
      yield '$word ';
    }
  }

  // ─── Mock Answer (when server is unreachable) ────────────
  AnswerModel _getMockAnswer(QuestionModel question) {
    return AnswerModel.sample;
  }

  // ─── Mark Helpful ─────────────────────────────────────────
  Future<void> markHelpful(String answerId, bool helpful) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // ─── Toggle Bookmark ─────────────────────────────────────
  Future<void> toggleBookmark(String answerId, bool bookmarked) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // ─── Get Related Questions ───────────────────────────────
  Future<List<String>> getRelatedQuestions(String topic) async {
    return [
      'प्रकाश का अपवर्तन क्या है?',
      'गोलीय दर्पण कितने प्रकार के होते हैं?',
      'उत्तल दर्पण और अवतल दर्पण में क्या अंतर है?',
    ];
  }

  // ─── Health Check ────────────────────────────────────────
  Future<bool> checkHealth() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/health'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
