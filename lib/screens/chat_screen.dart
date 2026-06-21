import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../widgets/chat_bubble.dart';
import '../providers/chat_provider.dart';

/// 💬 पढ़ो गुरु — Chat Screen (Core — 90% of user time)
class ChatScreen extends StatefulWidget {
  final String? questionId;

  const ChatScreen({super.key, this.questionId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  String? _pendingPhotoPath;

  @override
  void initState() {
    super.initState();
    final chatProvider = context.read<ChatProvider>();

    // Check if coming from camera with photo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      if (extra is Map<String, dynamic>) {
        _pendingPhotoPath = extra['photoPath'] as String?;
        if (_pendingPhotoPath != null) {
          // Auto-submit question from photo
          chatProvider.askQuestion(
            text: 'इस सवाल का जवाब दें',
            photoPath: _pendingPhotoPath,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty && _pendingPhotoPath == null) return;

    _textController.clear();
    _focusNode.unfocus();

    final chatProvider = context.read<ChatProvider>();
    await chatProvider.askQuestion(text: text, photoPath: _pendingPhotoPath);
    _pendingPhotoPath = null;
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      // ─── App Bar ────────────────────────────────────────
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('पढ़ो गुरु', style: TextStyle(fontSize: 16)),
                Text(
                  'ऑनलाइन • AI Tutor',
                  style: TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ],
            ),
            if (chatProvider.isStreaming) ...[
              const SizedBox(width: 8),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            onPressed: () {
              chatProvider.clearChat();
              setState(() => _pendingPhotoPath = null);
            },
            tooltip: 'चैट साफ़ करें',
          ),
        ],
      ),

      // ─── Body ──────────────────────────────────────────
      body: Column(
        children: [
          // Messages
          Expanded(
            child: chatProvider.messages.isEmpty
                ? _buildEmptyState()
                : _buildMessagesList(chatProvider),
          ),

          // Loading indicator
          if (chatProvider.isLoading)
            const Padding(padding: EdgeInsets.all(16), child: _ChatShimmer()),

          // Streaming indicator
          if (chatProvider.isStreaming) _buildStreamingBar(chatProvider),

          // Error
          if (chatProvider.error != null) _buildErrorBanner(chatProvider),

          // Input bar
          _buildInputBar(chatProvider),
        ],
      ),
    );
  }

  // ─── Empty State ─────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'आपका AI Tutor तैयार है!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'फोटो खींचे या टाइप करके सवाल पूछें\nNCERT का हर सवाल हिंदी में समझें',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.camera),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('फोटो खींचो'),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Messages List ───────────────────────────────────────
  Widget _buildMessagesList(ChatProvider chatProvider) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemCount:
          chatProvider.messages.length + (chatProvider.isStreaming ? 1 : 0),
      itemBuilder: (context, index) {
        // Streaming placeholder
        if (index == chatProvider.messages.length && chatProvider.isStreaming) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 48,
              top: 8,
              bottom: 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      left: BorderSide(color: AppTheme.primary, width: 3),
                    ),
                  ),
                  child: Text(
                    chatProvider.streamingText,
                    style: const TextStyle(fontSize: 15, height: 1.7),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4, top: 4),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ],
            ),
          );
        }

        final msg = chatProvider.messages[index];
        return ChatBubble(
          text: msg.text,
          isUser: msg.isUser,
          steps: msg.steps,
          relatedTopics: msg.relatedTopics,
          photoPath: msg.photoPath,
          isBookmarked: msg.isBookmarked,
          wasHelpful: msg.wasHelpful,
          onBookmark: () => chatProvider.toggleBookmark(index),
          onHelpful: (helpful) => chatProvider.markHelpful(index, helpful),
          onShare: () => _showShareOptions(msg.text),
          onRelatedTopicTap: (topic) {
            chatProvider.askQuestion(text: topic);
          },
        );
      },
    );
  }

  // ─── Streaming Bar ───────────────────────────────────────
  Widget _buildStreamingBar(ChatProvider chatProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.primary.withValues(alpha: 0.05),
      child: Row(
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 8),
          Text(
            'पढ़ो गुरु जवाब लिख रहे हैं...',
            style: TextStyle(fontSize: 12, color: AppTheme.primary),
          ),
          const Spacer(),
          GestureDetector(
            child: const Icon(
              Icons.stop_circle_outlined,
              size: 18,
              color: AppTheme.error,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Error Banner ────────────────────────────────────────
  Widget _buildErrorBanner(ChatProvider chatProvider) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              chatProvider.error!,
              style: const TextStyle(fontSize: 13, color: AppTheme.error),
            ),
          ),
          TextButton(
            onPressed: () {
              chatProvider.clearError();
              chatProvider.retry();
            },
            child: const Text('पुनः प्रयास', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // ─── Input Bar ───────────────────────────────────────────
  Widget _buildInputBar(ChatProvider chatProvider) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Camera button
          GestureDetector(
            onTap: () => context.push(AppRoutes.camera),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Text field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: const InputDecoration(
                  hintText: 'हिंदी में सवाल टाइप करें...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textHint,
                    fontFamily: 'NotoSansDevanagari',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Mic/Send button
          GestureDetector(
            onTap: _textController.text.trim().isNotEmpty
                ? _sendMessage
                : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('वॉइस इनपुट जल्द आ रहा है'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _textController.text.trim().isNotEmpty
                    ? AppTheme.primaryGradient
                    : null,
                color: _textController.text.trim().isEmpty
                    ? AppTheme.background
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _textController.text.trim().isNotEmpty
                    ? Icons.send_rounded
                    : Icons.mic_outlined,
                color: _textController.text.trim().isNotEmpty
                    ? Colors.white
                    : AppTheme.textHint,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareOptions(String text) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppTheme.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'शेयर करें',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.copy, color: Color(0xFF1565C0)),
                title: const Text('कॉपी करें'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.chat, color: Colors.white, size: 16),
                ),
                title: const Text('WhatsApp पर भेजें'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.share, color: AppTheme.primary),
                title: const Text('अन्य...'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shimmer Loading ───────────────────────────────────────
class _ChatShimmer extends StatefulWidget {
  const _ChatShimmer();

  @override
  State<_ChatShimmer> createState() => _ChatShimmerState();
}

class _ChatShimmerState extends State<_ChatShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final opacity = 0.3 + (_controller.value * 0.5);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 14,
                decoration: BoxDecoration(
                  color: AppTheme.divider.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    width: 200.0 + (i * 40),
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.divider.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.divider.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
