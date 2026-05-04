import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// FOTO PROFIL
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 15),

            /// NAMA
            const Text(
              "Agus Tina",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            /// STATUS
            const Text(
              "Mahasiswa Teknik Informatika",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            /// INFO LIST
            _infoTile(Icons.email, "Email", "agus@gmail.com"),
            _infoTile(Icons.phone, "Telepon", "08123456789"),
            _infoTile(Icons.location_on, "Alamat", "Pontianak"),

            const SizedBox(height: 20),

            /// BUTTON EDIT
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}