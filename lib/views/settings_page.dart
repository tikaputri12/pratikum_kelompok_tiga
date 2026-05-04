import 'package:flutter/material.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  bool isNotif = true;

  String nama = "Agus Tina";

  // ← TAMBAH INI: Sinkronkan isDark dengan themeNotifier saat halaman dibuka
  @override
  void initState() {
    super.initState();
    isDark = themeNotifier.value == ThemeMode.dark;
  }

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
        // ← UBAH: hapus backgroundColor hardcode, biar ikut tema
      ),

      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primary, // ← UBAH
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface, // ← TAMBAH
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Mahasiswa TI",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant, // ← UBAH
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                GestureDetector(
                  onTap: _editNama,
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onSurfaceVariant, // ← UBAH
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
                themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
              });
            },
          ),

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

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            subtitle: Text("AppChat v1.0\nUTS Kelompok 3"),
          ),

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