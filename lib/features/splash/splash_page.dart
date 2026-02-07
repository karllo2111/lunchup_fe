import 'package:flutter/material.dart';
import '../../core/storage/token_storage.dart';
import '../../core/services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await TokenStorage.getToken();

    if (!mounted) return;

    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    try {
      final role = await AuthService.getRole();

      if (!mounted) return;

      switch (role) {
        case 'seller':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'user':
          Navigator.pushReplacementNamed(context, '/user');
          break;
        case 'jastiper':
          Navigator.pushReplacementNamed(context, '/kurir');
          break;
        default:
          Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (_) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
