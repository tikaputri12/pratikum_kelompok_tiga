import 'package:flutter/material.dart';
import 'dart:ui';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  final List<Map<String, dynamic>> _calls = const [
    {
      'name': 'Budi Santoso',
      'time': 'Hari ini, 10:23',
      'duration': '5 menit 12 detik',
      'type': 'incoming',
      'avatar': 'B',
    },
    {
      'name': 'Siti Rahayu',
      'time': 'Hari ini, 08:45',
      'duration': '2 menit 30 detik',
      'type': 'outgoing',
      'avatar': 'S',
    },
    {
      'name': 'Ahmad Fauzi',
      'time': 'Kemarin, 21:10',
      'duration': 'Tidak terjawab',
      'type': 'missed',
      'avatar': 'A',
    },
    {
      'name': 'Dewi Lestari',
      'time': 'Kemarin, 15:33',
      'duration': '10 menit 05 detik',
      'type': 'incoming',
      'avatar': 'D',
    },
    {
      'name': 'Raka Pratama',
      'time': 'Kemarin, 09:00',
      'duration': 'Tidak terjawab',
      'type': 'missed',
      'avatar': 'R',
    },
    {
      'name': 'Nina Kartika',
      'time': '2 hari lalu, 18:22',
      'duration': '7 menit 44 detik',
      'type': 'outgoing',
      'avatar': 'N',
    },
    {
      'name': 'Hendra Wijaya',
      'time': '3 hari lalu, 12:05',
      'duration': '1 menit 20 detik',
      'type': 'incoming',
      'avatar': 'H',
    },
  ];

  Color _typeColor(String type) {
    switch (type) {
      case 'incoming':
        return const Color(0xFF6C63FF);
      case 'outgoing':
        return const Color(0xFF43E97B);
      case 'missed':
        return const Color(0xFFFF6584);
      default:
        return Colors.white;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'incoming':
        return Icons.call_received_rounded;
      case 'outgoing':
        return Icons.call_made_rounded;
      case 'missed':
        return Icons.call_missed_rounded;
      default:
        return Icons.call_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6C63FF).withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF6584).withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Riwayat Panggilan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_calls.length} panggilan',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Filter chips
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildChip('Semua', true),
                        _buildChip('Masuk', false),
                        _buildChip('Keluar', false),
                        _buildChip('Tidak Terjawab', false),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Call List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _calls.length,
                    itemBuilder: (context, index) {
                      final call = _calls[index];
                      return _buildCallCard(call);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // FAB
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_call, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF9B59B6)],
              )
            : null,
        color: isSelected ? null : Colors.white.withOpacity(0.07),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Colors.white.withOpacity(0.1),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCallCard(Map<String, dynamic> call) {
    final color = _typeColor(call['type']);
    final icon = _typeIcon(call['type']);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    call['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(icon, color: color, size: 13),
                        const SizedBox(width: 4),
                        Text(
                          call['duration'],
                          style: TextStyle(
                            color: call['type'] == 'missed'
                                ? color
                                : Colors.white.withOpacity(0.45),
                            fontSize: 12,
                            fontWeight: call['type'] == 'missed'
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      call['time'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Call button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withOpacity(0.15),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(Icons.call_rounded, color: color, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
