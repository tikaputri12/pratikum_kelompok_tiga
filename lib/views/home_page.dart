import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../chat_app/chat_detail_screen.dart';
import 'profile_page.dart';
import 'call_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final String apiText;
  const HomePage({super.key, required this.apiText});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  List<Map<String, dynamic>> newChats = [];

  String searchQuery = "";

  bool isGroup = false;

  List<Map<String, dynamic>> groups = [
    {
      "profile": "Kelompok 3",
      "message": "Diskusi tugas",
      "time": "09:00",
      "status": "read",
    },
    {
      "profile": "Project Flutter",
      "message": "Deadline besok!",
      "time": "11:00",
      "status": "delivered",
    },
  ];

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Panggilan"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget _getPage() {
    switch (_currentIndex) {
      case 0:
        return const ProfilePage();
      case 1:
        return _buildChatPage();
      case 2:
        return const CallPage();
      case 3:
        return const SettingsPage();
      default:
        return _buildChatPage();
    }
  }

  Widget _buildChatPage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.chat, color: Colors.blue, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "AppChat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "UTS Kelas A - Kelompok 3",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _onlineItem("Anda", true),
                  _onlineItem("Ainun", false),
                  _onlineItem("Ryan", false),
                  _onlineItem("Adinda", false),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "People",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                ElevatedButton(
                  onPressed: isGroup
                      ? _showCreateGroupDialog
                      : _showAddContactDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isGroup ? "+ Group" : "+ Kontak"),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _tab("Contact", !isGroup, () {
                      setState(() {
                        isGroup = false;
                      });
                    }),
                  ),
                  Expanded(
                    child: _tab("Group", isGroup, () {
                      setState(() {
                        isGroup = true;
                      });
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer<AuthViewModel>(
                builder: (context, authVM, child) {
                  if (authVM.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (authVM.error.isNotEmpty) {
                    return Center(
                      child: Text(
                        authVM.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final allChats = isGroup
                      ? groups
                      : <Map<String, dynamic>>[
                          ...newChats,
                          ...authVM.chats.map(
                            (chat) => Map<String, dynamic>.from(chat),
                          ),
                        ];

                  final chats = allChats.where((chat) {
                    final name =
                        chat['profile']?.toString().toLowerCase() ?? '';
                    final message =
                        chat['message']?.toString().toLowerCase() ?? '';
                    final query = searchQuery.toLowerCase();

                    return name.contains(query) || message.contains(query);
                  }).toList();

                  if (chats.isEmpty) {
                    return Center(
                      child: Text(
                        isGroup
                            ? "Anda belum memiliki group"
                            : "Data tidak ditemukan",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            child: Text(
                              chat['profile'] != null &&
                                      chat['profile'].toString().isNotEmpty
                                  ? chat['profile'].toString()[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          title: Text(
                            chat['profile']?.toString() ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            chat['message']?.toString() ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                chat['time']?.toString() ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _messageStatus(chat['status']?.toString() ?? ''),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatDetailScreen(
                                  chats: chats,
                                  selectedIndex: index,
                                ),
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
    );
  }

  void _showAddContactDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Kontak"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Masukkan nama"),
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
                final name = nameController.text.trim();

                if (name.isNotEmpty) {
                  setState(() {
                    newChats.insert(0, {
                      "profile": name,
                      "message": "Kontak baru ditambahkan",
                      "time": "Baru",
                      "status": "sent",
                    });
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  Widget _messageStatus(String status) {
    switch (status) {
      case "sent":
        return const Icon(Icons.check, size: 16, color: Colors.grey);
      case "delivered":
        return const Icon(Icons.done_all, size: 16, color: Colors.grey);
      case "read":
        return const Icon(Icons.done_all, size: 16, color: Colors.blue);
      default:
        return const SizedBox();
    }
  }

  Widget _tab(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).colorScheme.surface
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _onlineItem(String name, bool isMe) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              child: Text(
                name[0],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );
}

  void _showCreateGroupDialog() {
    final TextEditingController groupNameController = TextEditingController();

    final authVM = context.read<AuthViewModel>();

    final contacts = authVM.chats
        .map((chat) => Map<String, dynamic>.from(chat))
        .toList();

    List<String> selectedContacts = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Buat Group"),
              content: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan nama group",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          final name = contact['profile']?.toString() ?? '';

                          return CheckboxListTile(
                            value: selectedContacts.contains(name),
                            onChanged: (value) {
                              setDialogState(() {
                                if (value == true) {
                                  selectedContacts.add(name);
                                } else {
                                  selectedContacts.remove(name);
                                }
                              });
                            },
                            secondary: CircleAvatar(
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : "?",
                              ),
                            ),
                            title: Text(name),
                          );
                        },
                      ),
                    ),
                  ],
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
                    final groupName = groupNameController.text.trim();

                    if (groupName.isNotEmpty && selectedContacts.isNotEmpty) {
                      setState(() {
                        groups.insert(0, {
                          "profile": groupName,
                          "message":
                              "${selectedContacts.length} anggota: ${selectedContacts.join(', ')}",
                          "time": "Baru",
                          "status": "sent",
                        });
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Buat"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
