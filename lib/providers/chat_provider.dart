import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/question_model.dart';
import '../models/answer_model.dart';
import '../services/ai_service.dart';

/// पढ़ो गुरु — Chat State Provider
class ChatProvider extends ChangeNotifier {
  final AIService _aiService = AIService();

  // ─── State ────────────────────────────────────────────────
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isStreaming = false;
  String _streamingText = '';
  String? _error;
  QuestionModel? _pendingQuestion;

  // ─── Getters ──────────────────────────────────────────────
  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isStreaming => _isStreaming;
  String get streamingText => _streamingText;
  String? get error => _error;

  // ─── Ask Question ─────────────────────────────────────────
  Future<void> askQuestion({
    required String text,
    String? photoPath,
    String? subject,
  }) async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final question = QuestionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      photoUrl: photoPath,
      subject: subject,
    );

    _pendingQuestion = question;

    // Add user message
    _messages.add(ChatMessage(
      text: text,
      photoPath: photoPath,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    try {
      // Stream the answer
      _isLoading = false;
      _isStreaming = true;
      _streamingText = '';
      notifyListeners();

      await for (final chunk in _aiService.streamAnswer(question)) {
        _streamingText += chunk;
        notifyListeners();
      }

      // Final answer
      final answer = await _aiService.askQuestion(question);
      _messages.add(ChatMessage(
        text: answer.answer,
        steps: answer.steps,
        relatedTopics: answer.relatedTopics,
        isUser: false,
        answerModel: answer,
        timestamp: DateTime.now(),
      ));

      _isStreaming = false;
      _streamingText = '';
      _pendingQuestion = null;
      notifyListeners();
    } catch (e) {
      _error = 'कुछ गलत हो गया। कृपया पुनः प्रयास करें।';
      _isLoading = false;
      _isStreaming = false;
      _pendingQuestion = null;
      notifyListeners();
    }
  }

  // ─── Retry ────────────────────────────────────────────────
  Future<void> retry() async {
    if (_pendingQuestion != null) {
      // Remove last user message
      if (_messages.isNotEmpty && _messages.last.isUser) {
        _messages.removeLast();
      }
      await askQuestion(text: _pendingQuestion!.text);
    }
  }

  // ─── Toggle Bookmark ──────────────────────────────────────
  Future<void> toggleBookmark(int messageIndex) async {
    if (messageIndex >= _messages.length) return;
    final msg = _messages[messageIndex];
    if (msg.isUser || msg.answerModel == null) return;

    final newBookmarkState = !msg.isBookmarked;
    await _aiService.toggleBookmark(msg.answerModel!.id, newBookmarkState);

    _messages[messageIndex] = msg.copyWith(isBookmarked: newBookmarkState);
    notifyListeners();
  }

  // ─── Mark Helpful ─────────────────────────────────────────
  Future<void> markHelpful(int messageIndex, bool helpful) async {
    if (messageIndex >= _messages.length) return;
    final msg = _messages[messageIndex];
    if (msg.isUser || msg.answerModel == null) return;

    await _aiService.markHelpful(msg.answerModel!.id, helpful);
    _messages[messageIndex] = msg.copyWith(wasHelpful: helpful);
    notifyListeners();
  }

  // ─── Clear Chat ───────────────────────────────────────────
  void clearChat() {
    _messages.clear();
    _error = null;
    _streamingText = '';
    _isStreaming = false;
    notifyListeners();
  }

  // ─── Clear Error ──────────────────────────────────────────
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

/// पढ़ो गुरु — Chat Message Model
class ChatMessage {
  final String text;
  final String? photoPath;
  final bool isUser;
  final List<String>? steps;
  final List<String>? relatedTopics;
  final AnswerModel? answerModel;
  final DateTime timestamp;
  final bool isBookmarked;
  final bool wasHelpful;

  ChatMessage({
    required this.text,
    this.photoPath,
    required this.isUser,
    this.steps,
    this.relatedTopics,
    this.answerModel,
    DateTime? timestamp,
    this.isBookmarked = false,
    this.wasHelpful = false,
  }) : timestamp = timestamp ?? DateTime.now();

  ChatMessage copyWith({
    bool? isBookmarked,
    bool? wasHelpful,
    String? text,
    List<String>? steps,
    List<String>? relatedTopics,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      photoPath: photoPath,
      isUser: isUser,
      steps: steps ?? this.steps,
      relatedTopics: relatedTopics ?? this.relatedTopics,
      answerModel: answerModel,
      timestamp: timestamp,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      wasHelpful: wasHelpful ?? this.wasHelpful,
    );
  }
}
