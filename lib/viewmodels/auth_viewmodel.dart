import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthViewModel extends ChangeNotifier {
  // Variabel utama
  List<dynamic> _chats = [];
  String _message = "UTS Kelas A - Kelompok 3";
  String _error = "";
  bool _isLoading = false;

  // Getter agar bisa diakses oleh UI/HomePage
  List<dynamic> get chats => _chats;
  String get message => _message;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> getApiData() async {
    _isLoading = true;
    _error = "";
    _chats = []; // Kosongkan list sebelum ambil data baru
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok3/chats'),
      );

      // Print untuk debug di console VS Code
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        // --- LOGIKA PENGECEKAN STRUKTUR (DISELIPKAN DI SINI) ---
        if (decodedData is Map<String, dynamic>) {
          // Jika API membungkus data dalam key 'data'
          if (decodedData.containsKey('data') && decodedData['data'] is List) {
            _chats = decodedData['data'];
          } else {
            // Jika format Map tapi tidak ada list 'data', set ke list kosong agar tidak error
            _chats = [];
          }
          
          // Ambil message dari API jika ada
          if (decodedData.containsKey('message') && decodedData['message'] != null) {
            _message = decodedData['message'].toString();
          }
        } else if (decodedData is List) {
          // Jika API langsung memberikan List tanpa pembungkus Map
          _chats = decodedData;
        }
        // -------------------------------------------------------

      } else {
        _error = "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      _error = "Gagal terhubung ke internet. Cek koneksi kamu.";
      print("Detail Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}