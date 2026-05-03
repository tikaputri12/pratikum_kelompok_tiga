import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final List chats;
  final int selectedIndex;

  const ChatDetailScreen({
    super.key,
    required this.chats,
    required this.selectedIndex,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  List messages = [];

  @override
  void initState() {
    super.initState();

    /// Ambil chat dari HomePage
    final chat = widget.chats[widget.selectedIndex];

    messages = [
      {
        "sender": chat['profile'],
        "message": chat['message'],
        "time": chat['time'],
        "isMe": false,
      }
    ];
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "sender": "Saya",
        "message": _controller.text,
        "time": TimeOfDay.now().format(context),
        "isMe": true,
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chat = widget.chats[widget.selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(chat['profile']),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          /// 🔥 LIST CHAT
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return Align(
                  alignment: msg['isMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg['isMe']
                          ? Colors.blue
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: msg['isMe']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['message'],
                          style: TextStyle(
                            color: msg['isMe']
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'],
                          style: TextStyle(
                            fontSize: 10,
                            color: msg['isMe']
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// 🔥 INPUT PESAN
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ketik pesan...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}