import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Login/register_page.dart';
import 'package:gamify_todo/3%20Page/navbar_page_manager.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Giriş', style: TextStyle(color: Colors.white, fontSize: 24)),
              const SizedBox(height: 20),
              _buildTextField('E-Posta'),
              const SizedBox(height: 16),
              _buildTextField('Şifre', obscureText: true),
              const SizedBox(height: 20),
              _buildLoginButton(),
              const SizedBox(height: 16),
              _buildFooterLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          NavigatorService().goTo(
            const NavbarPageManager(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Login'),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            NavigatorService().goTo(
              const RegisterApp(),
            );
          },
          child: const Text(
            'Hesap oluştur',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const Text('Şifremi unuttum', style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}
