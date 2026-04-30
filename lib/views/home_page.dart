import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../chat_app/chat_detail_screen.dart';

class HomePage extends StatefulWidget {
  final String apiText;
  const HomePage({super.key, required this.apiText});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().getApiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔥 HEADER + JUDUL
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "UTS Kelas A - Kelompok 3",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "People",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("+ Add"),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// 🔥 TAB CONTACT / GROUP
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(child: _tab("Contact", true)),
                    Expanded(child: _tab("Group", false)),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// 🔥 SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔥 LIST CHAT
              Expanded(
                child: Consumer<AuthViewModel>(
                  builder: (context, authVM, child) {
                    if (authVM.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (authVM.error.isNotEmpty) {
                      return Center(
                        child: Text(
                          authVM.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final chats = authVM.chats;

                    if (chats.isEmpty) {
                      return const Center(child: Text("Tidak ada pesan"));
                    }

                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        if (chat == null) return const SizedBox();

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,

                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                chat['profile'] != null
                                    ? chat['profile']
                                        .toString()[0]
                                        .toUpperCase()
                                    : '?',
                              ),
                            ),

                            title: Text(
                              chat['profile']?.toString() ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              chat['message']?.toString() ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            trailing: Text(
                              chat['time']?.toString() ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ChatDetailScreen(chats: chats),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.message),
      ),
    );
  }

  /// 🔥 TAB COMPONENT
  Widget _tab(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}