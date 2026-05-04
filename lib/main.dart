import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'viewmodels/auth_viewmodel.dart';
import 'views/home_page.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
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
      home: const _StartPage(), 
    );
  }
  
}
class _StartPage extends StatefulWidget {
  const _StartPage();

  @override
  State<_StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<_StartPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage(apiText: '',)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}