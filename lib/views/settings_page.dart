import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  bool isNotif = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: ListView(
        children: [
          /// PROFILE
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text("Agus Tina"),
            subtitle: Text("Mahasiswa TI"),
          ),

          const Divider(),

          /// DARK MODE
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
              });
            },
          ),

          /// NOTIF
          SwitchListTile(
            title: const Text("Notifikasi"),
            value: isNotif,
            onChanged: (val) {
              setState(() {
                isNotif = val;
              });
            },
          ),

          const Divider(),

          /// ABOUT
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            subtitle: Text("AppChat v1.0\nUTS Kelompok 3"),
          ),

          /// LOGOUT
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}