import 'package:flutter/material.dart';

void main() => runApp(const RegisterApp());

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hesap Oluştur', style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 20),
                _buildTextField('Kullanıcı Adı', controller: _usernameController, validator: _usernameValidator),
                const SizedBox(height: 16),
                _buildTextField('E-Posta', controller: _emailController, validator: _emailValidator),
                const SizedBox(height: 16),
                _buildTextField('Şifre', controller: _passwordController, obscureText: true, validator: _passwordValidator),
                const SizedBox(height: 20),
                _buildRegisterButton(),
                const SizedBox(height: 16),
                _buildFooterLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool obscureText = false, TextEditingController? controller, String? Function(String?)? validator}) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
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
      validator: validator,
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Handle account creation logic here
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hesap oluşturuluyor...')));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Hesap Oluştur'),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Giriş yap', style: TextStyle(color: Colors.white70)),
        Text('Şifremi unuttum', style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen kullanıcı adı girin';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen e-posta adresinizi girin';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifrenizi girin';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }
}
