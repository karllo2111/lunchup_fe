import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool loading = false;

  Future<void> handleLogin() async {
  setState(() => loading = true);

  try {
    final role = await AuthService.login(
      email: emailC.text,
      password: passwordC.text,
    );

    if (!mounted) return;

    switch (role) {
      case 'seller': // admin di app
        Navigator.pushReplacementNamed(context, '/admin');
        break;

      case 'user': // user
        Navigator.pushReplacementNamed(context, '/user');
        break;

      case 'jastiper': // kurir
        Navigator.pushReplacementNamed(context, '/courier');
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Role tidak dikenal: $role')),
        );
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login gagal')),
    );
  } finally {
    if (mounted) setState(() => loading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email')),
            TextField(
              controller: passwordC,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : handleLogin,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
