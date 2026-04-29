import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'viewmodels/auth_viewmodel.dart';
// Import HomePage jika ingin langsung ke sana, atau AuthScreen sesuai kodemu
import 'views/home_page.dart'; 
import 'views/auth_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Mendaftarkan AuthViewModel agar bisa dipakai di seluruh aplikasi
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTS Kelompok 3',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      // Jika ingin langsung ke daftar chat setelah login:
      home: const AuthScreen(), 
    );
  }
}