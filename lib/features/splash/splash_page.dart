import 'package:flutter/material.dart';
import '../../core/storage/token_storage.dart';
// import '../../core/services/auth_service.dart';

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
  final role = await TokenStorage.getRole();

  if (!mounted) return;

  if (token == null || role == null) {
    Navigator.pushReplacementNamed(context, '/home');
    return;
  }

  switch (role) {
    case 'seller':
      Navigator.pushReplacementNamed(context, '/admin');
      break;
    case 'user':
      Navigator.pushReplacementNamed(context, '/user');
      break;
    case 'jastiper':
      Navigator.pushReplacementNamed(context, '/courier');
      break;
    default:
      Navigator.pushReplacementNamed(context, '/login');
  }
}



  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
