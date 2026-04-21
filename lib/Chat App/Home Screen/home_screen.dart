import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Demo data untuk story
  static final List<Map<String, dynamic>> _stories = [
    {'name': 'Darlene', 'initials': 'DR', 'color': Color(0xFF5C6BC0), 'hasStory': true},
    {'name': 'Alicia', 'initials': 'AL', 'color': Color(0xFFE91E63), 'hasStory': true},
    {'name': 'Kevin', 'initials': 'KM', 'color': Color(0xFFFF7043), 'hasStory': true},
    {'name': 'James', 'initials': 'JW', 'color': Color(0xFF78909C), 'hasStory': false},
  ];

  // Demo data untuk chat
  static final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Darlene Robert',
      'initials': 'DR',
      'color': Color(0xFF5C6BC0),
      'preview': 'typing...',
      'isTyping': true,
      'time': '3m ago',
      'unread': 3,
      'isOnline': true,
    },
    {
      'name': 'Alicia Keys',
      'initials': 'AL',
      'color': Color(0xFFE91E63),
      'preview': 'Okay sure, see you tomorrow 👍',
      'isTyping': false,
      'time': '15m ago',
      'unread': 1,
      'isOnline': false,
    },
    {
      'name': 'Group - Kelompok 3',
      'initials': 'GR',
      'color': Color(0xFF00897B),
      'preview': 'Donny: jangan lupa tugasnya ya!',
      'isTyping': false,
      'time': '1h ago',
      'unread': 7,
      'isOnline': false,
    },
    {
      'name': 'Kevin Michael',
      'initials': 'KM',
      'color': Color(0xFFFF7043),
      'preview': '📷 Photo shared',
      'isTyping': false,
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': false,
    },
    {
      'name': 'James Wilson',
      'initials': 'JW',
      'color': Color(0xFF78909C),
      'preview': 'Can we reschedule the meeting?',
      'isTyping': false,
      'time': 'Mon',
      'unread': 0,
      'isOnline': false,
    },
    {
      'name': 'Sarah Connor',
      'initials': 'SC',
      'color': Color(0xFF8E24AA),
      'preview': 'Thanks for the help!',
      'isTyping': false,
      'time': 'Sun',
      'unread': 0,
      'isOnline': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ✅ TIDAK ada bottomNavigationBar — dihandle oleh MainScreen di main.dart
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00BF6D),
        elevation: 4,
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 22),
      ),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildStorySection()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.8,
                    ),
                  ),
                  const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF00BF6D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildChatItem(_chats[index]),
              childCount: _chats.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 155,
      backgroundColor: const Color(0xFF00BF6D),
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        background: Container(
          color: const Color(0xFF00BF6D),
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Row(
                    children: [
                      _buildHeaderIconBtn(Icons.search),
                      const SizedBox(width: 10),
                      _buildHeaderIconBtn(Icons.person_add_outlined),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white70, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      'Search messages...',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIconBtn(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildStorySection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[100]!, width: 1)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildMyStatus(),
            const SizedBox(width: 12),
            ..._stories.map((s) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildStoryAvatar(s),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildMyStatus() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF00BF6D), width: 2),
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Color(0xFFE8FFF5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Color(0xFF00BF6D), size: 22),
          ),
        ),
        const SizedBox(height: 5),
        const Text('My Status', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildStoryAvatar(Map<String, dynamic> story) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: story['hasStory'] ? const Color(0xFF00BF6D) : Colors.grey[400]!,
              width: 2.5,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: story['color'],
            child: Text(
              story['initials'],
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(story['name'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    final bool hasUnread = chat['unread'] > 0;

    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: chat['color'],
                      child: Text(
                        chat['initials'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    if (chat['isOnline'])
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF25D366),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                      chat['isTyping']
                          ? const Text(
                              'typing...',
                              style: TextStyle(fontSize: 12, color: Color(0xFF00BF6D), fontStyle: FontStyle.italic),
                            )
                          : Text(
                              chat['preview'],
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat['time'],
                      style: TextStyle(
                        fontSize: 11,
                        color: hasUnread ? const Color(0xFF00BF6D) : Colors.grey[400],
                        fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (hasUnread)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00BF6D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          chat['unread'].toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      )
                    else
                      const SizedBox(height: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 0.5, indent: 76, color: Colors.grey[100]),
      ],
    );
  }
}