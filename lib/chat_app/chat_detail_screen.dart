import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final List<dynamic> chats;

  const ChatDetailScreen({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Detail"),
        backgroundColor: const Color(0xFF14A38B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final isSender = chat['type'] == 'sender';

          return Align(
            alignment:
                isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSender ? const Color(0xFF14A38B) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                chat['message'] ?? '',
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}