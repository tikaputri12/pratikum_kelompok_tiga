import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;

  String apiMessage = ""; // 🔥 hasil dari API

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animController.dispose();
    super.dispose();
  }

  /////////////////////////////////////////////
  /// 🔥 API CALL
  /////////////////////////////////////////////
  Future<void> fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok3/profile",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          apiMessage = response.body;
        });
      } else {
        setState(() {
          apiMessage = "Gagal ambil data (${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        apiMessage = "Error: $e";
      });
    }
  }

  /////////////////////////////////////////////
  /// 🔥 LOGIN
  /////////////////////////////////////////////
  void _login() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await fetchProfile(); // 🔥 ambil API saat login

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login + API berhasil')),
      );
    }
  }

  /////////////////////////////////////////////
  /// UI
  /////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: Stack(
        children: [
          _bgCircle(-80, -60, 280, const Color(0xFF6C63FF)),
          _bgCircle(null, -60, 320, const Color(0xFFFF6584),
              bottom: -100),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// 🔥 LOGO + TITLE + API TEXT
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      _logo(),
                      const SizedBox(height: 16),
                      const Text(
                        'ChatApp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// 🔥 HASIL API MUNCUL DI SINI
                      Text(
                        apiMessage.isEmpty
                            ? "Belum ambil data API"
                            : apiMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                _tabBar(),

                const SizedBox(height: 20),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _loginForm(),
                      const Center(
                        child: Text(
                          "Register belum dihubungkan API",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////////////
  /// 🔥 COMPONENT UI
  /////////////////////////////////////////////

  Widget _bgCircle(double? top, double right, double size, Color color,
      {double? bottom}) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.3), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
        ),
      ),
      child: const Icon(Icons.chat, color: Colors.white),
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(14),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF6C63FF),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          tabs: const [
            Tab(text: "Login"),
            Tab(text: "Register"),
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////////////
  /// 🔥 LOGIN FORM
  /////////////////////////////////////////////
  Widget _loginForm() {
    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                _field(_loginEmailController, "Email", Icons.email),
                const SizedBox(height: 16),
                _field(
                  _loginPasswordController,
                  "Password",
                  Icons.lock,
                  obscure: _obscurePassword,
                  toggle: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                ),
                const SizedBox(height: 30),

                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Login + Ambil API"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label,
    IconData icon, {
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    return TextFormField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: toggle != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: toggle,
              )
            : null,
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}