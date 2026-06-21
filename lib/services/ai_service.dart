import 'dart:async';
import '../models/question_model.dart';
import '../models/answer_model.dart';

/// पढ़ो गुरु — AI Service
/// Will be connected to Genkit + OpenAI in future sprint.
/// Currently returns mock data for UI development.
class AIService {
  // Simulate AI processing delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  /// Submit a question and get AI answer
  Future<AnswerModel> askQuestion(QuestionModel question) async {
    await _simulateDelay();

    // TODO: Replace with Genkit flow call
    // final response = await runFlow(
    //   url: 'https://api.padhoguru.com/ask',
    //   input: question.toJson(),
    // );

    return AnswerModel.sample;
  }

  /// Stream answer chunks (for word-by-word display)
  Stream<String> streamAnswer(QuestionModel question) async* {
    // TODO: Replace with Genkit streaming flow call
    // final stream = streamFlow(
    //   url: 'https://api.padhoguru.com/ask/stream',
    //   input: question.toJson(),
    // );

    final sample = AnswerModel.sample.answer;
    final words = sample.split(' ');

    for (final word in words) {
      await Future.delayed(const Duration(milliseconds: 80));
      yield '$word ';
    }
  }

  /// Mark answer as helpful/not helpful
  Future<void> markHelpful(String answerId, bool helpful) async {
    // TODO: Firestore update
    await Future.delayed(const Duration(milliseconds: 200));
  }

  /// Toggle bookmark
  Future<void> toggleBookmark(String answerId, bool bookmarked) async {
    // TODO: Firestore update
    await Future.delayed(const Duration(milliseconds: 200));
  }

  /// Get related questions
  Future<List<String>> getRelatedQuestions(String topic) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      'प्रकाश का अपवर्तन क्या है?',
      'गोलीय दर्पण कितने प्रकार के होते हैं?',
      'उत्तल दर्पण और अवतल दर्पण में क्या अंतर है?',
    ];
  }
}
