import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        // ← UBAH: hapus 'const' di children
        children: [
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
        backgroundColor: Theme.of(context).colorScheme.primaryContainer, // ← UBAH
        child: Text(
          name[0],
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer, // ← TAMBAH
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface, // ← TAMBAH
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant, // ← TAMBAH
        ),
      ),
      trailing: Icon(
        Icons.call,
        color: isMissed ? Colors.red : Colors.green,
      ),
    );
  }
}