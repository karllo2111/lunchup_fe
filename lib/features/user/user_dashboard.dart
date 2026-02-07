import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  Future<void> _logout() async {
    await AuthService.logout();
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: _logout,
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
