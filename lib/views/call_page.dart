import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _callItem("Ainun", "Hari ini, 10:30", true),
          _callItem("Ryan", "Kemarin, 21:15", false),
          _callItem("Adinda", "Kemarin, 18:00", true),
        ],
      ),
    );
  }
}

class _callItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isMissed;

  const _callItem(this.name, this.time, this.isMissed);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(name[0]),
      ),
      title: Text(name),
      subtitle: Text(time),
      trailing: Icon(
        Icons.call,
        color: isMissed ? Colors.red : Colors.green,
      ),
    );
  }
}