import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
// import 'features/auth/login_page.dart';
// import 'features/auth/register_page.dart';
import 'config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    ...AppRoutes.routes,
  },
);

  }
}
