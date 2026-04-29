import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String url =
      "https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok3/check";

  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
      },
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal ambil API: ${response.statusCode}");
    }
  }
}