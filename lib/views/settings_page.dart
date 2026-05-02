import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  bool isNotif = true;

  String nama = "Agus Tina";

  /// 🔥 EDIT NAMA
  void _editNama() {
    TextEditingController controller = TextEditingController(text: nama);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Nama"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Masukkan nama baru",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                nama = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
      ),

      body: ListView(
        children: [
          /// 🔥 PROFILE (SUDAH KEREN + BISA EDIT)
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Mahasiswa TI",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const Spacer(),

                GestureDetector(
                  onTap: _editNama,
                  child: const Icon(Icons.edit, color: Colors.grey),
                ),
              ],
            ),
          ),

          const Divider(),

          /// 🔥 DARK MODE
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
              });
            },
          ),

          /// 🔥 NOTIFIKASI
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

          /// 🔥 ABOUT
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            subtitle: Text("AppChat v1.0\nUTS Kelompok 3"),
          ),

          /// 🔥 LOGOUT
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