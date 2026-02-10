import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'features/auth/login_page.dart';
import 'features/auth/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LunchUp',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        // tambahkan route lain sesuai kebutuhan
        // '/admin': (context) => const AdminDashboard(),
        // '/user': (context) => const UserDashboard(),
        // '/courier': (context) => const CourierDashboard(),
      },
    );
  }
}
