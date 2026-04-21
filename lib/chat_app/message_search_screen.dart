import 'package:flutter/material.dart';

class MessageSearchScreen extends StatelessWidget {
  const MessageSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Search')),
      body: const Center(child: Text('Message Search Screen')),
    );
  }
}
