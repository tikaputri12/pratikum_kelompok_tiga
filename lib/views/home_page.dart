import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class HomePage extends StatefulWidget {
  // apiText tetap diterima di constructor agar Navigator.push tidak error
  final String apiText;
  const HomePage({super.key, required this.apiText});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Memanggil API secara otomatis saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().getApiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BFA5),
      // --- INTEGRASI APPBAR ---
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "UTS Kelas A - Kelompok 3", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<AuthViewModel>(
              builder: (context, authVM, child) {
                return Text(
                  authVM.message.isEmpty ? widget.apiText : authVM.message, 
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white70),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Bagian Header "Messages"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // --- BAGIAN PUTIH (LIST CHAT) ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer<AuthViewModel>(
                  builder: (context, authVM, child) {
                    if (authVM.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF00BFA5)),
                      );
                    }

                    if (authVM.error.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(authVM.error, style: const TextStyle(color: Colors.red)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => authVM.getApiData(),
                              child: const Text("Coba Lagi"),
                            )
                          ],
                        ),
                      );
                    }

                    final chats = authVM.chats;
                    if (chats.isEmpty) {
                      return const Center(child: Text("Tidak ada pesan"));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      itemCount: chats.length,
                      separatorBuilder: (context, index) => const Divider(indent: 80, height: 1),
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        if (chat == null) return const SizedBox.shrink();

                        // --- KODE LISTTILE YANG DISALIN ---
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              chat['profile'] != null ? chat['profile'].toString()[0].toUpperCase() : '?', 
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            chat['profile']?.toString() ?? 'No Name', 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            chat['message']?.toString() ?? '', 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            chat['time']?.toString() ?? '', 
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00BFA5),
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}