import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String? questionId;

  const ChatScreen({super.key, this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(child: Text('Chat Screen - Coming in Sprint 3')),
    );
  }
}
