import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String role = 'user';
  bool loading = false;

  Future<void> handleRegister() async {
  setState(() => loading = true);

  try {
    await AuthService.register(
      username: usernameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text,
      role: role,
    );

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Register gagal')),
    );
  } finally {
    if (mounted) setState(() => loading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),

            DropdownButton<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: 'user', child: Text('User')),
                DropdownMenuItem(value: 'jastiper', child: Text('Jastiper')),
              ],
              onChanged: (v) => setState(() => role = v!),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : handleRegister,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
