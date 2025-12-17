import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_controller.dart';
import '../models/message.dart';
import '../storage/chat_storage.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key,
    this.controller,
    this.enableAutoReply = true,
    List<String>? autoReplies,
    Random? random,
    ChatStorage? storage,
  }) : autoReplies =
           autoReplies ??
           const [
             "Hi there! How can I help you today?",
             "Got it — let me check that.",
             "Thanks for reaching out!",
             "I’m escalating this to our specialist team.",
             "Can you share a bit more detail?",
           ],
       random = random ?? Random(),
       storage = storage ?? SharedPrefsChatStorage();

  final ChatController? controller;
  final bool enableAutoReply;
  final List<String> autoReplies;
  final Random random;
  final ChatStorage storage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<Message> _messages = [];

  Timer? _autoReplyTimer;

  @override
  void initState() {
    super.initState();

    // Register controller callback so AppBar can clear chat
    widget.controller?.clear = clearMessages;

    _loadMessages();
  }

  @override
  void dispose() {
    _autoReplyTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> clearMessages() async {
    // Clear storage but do not crash UX if persistence fails
    try {
      await widget.storage.clear();
    } catch (e) {
      debugPrint('Clear messages failed: $e');
    }

    if (!mounted) return;
    setState(() => _messages.clear());
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Clear input immediately so UI always updates
    _controller.clear();

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
    });

    _scrollToBottom();

    try {
      await _saveMessages();
    } catch (e) {
      debugPrint('Save messages failed: $e');
    }

    if (widget.enableAutoReply) {
      _autoReplyTimer?.cancel();
      _autoReplyTimer = Timer(const Duration(seconds: 1), () async {
        if (!mounted) return;
        try {
          await _sendAutoReply();
        } catch (e) {
          debugPrint('Auto-reply failed: $e');
        }
      });
    }
  }

  Future<void> _sendAutoReply() async {
    final reply =
        widget.autoReplies[widget.random.nextInt(widget.autoReplies.length)];

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: reply,
          timestamp: DateTime.now(),
          isMe: false,
        ),
      );
    });

    try {
      await _saveMessages();
    } catch (e) {
      debugPrint('Save messages failed: $e');
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _loadMessages() async {
    try {
      final loaded = await widget.storage.load();

      if (!mounted) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(loaded);
      });

      _scrollToBottom();
    } catch (e) {
      debugPrint('Load messages failed: $e');
    }
  }

  Future<void> _saveMessages() async {
    await widget.storage.save(_messages);
  }

  String _formatTime(DateTime time) => DateFormat('HH:mm').format(time);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              final align = msg.isMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft;
              final bubbleColor = msg.isMe
                  ? Colors.blueAccent
                  : Colors.grey.shade300;
              final textColor = msg.isMe ? Colors.white : Colors.black87;

              return Align(
                alignment: align,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: msg.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 320),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: bubbleColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatTime(msg.timestamp),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('chat_input'),
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type a message…',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  key: const Key('chat_send'),
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
