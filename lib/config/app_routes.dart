import 'package:flutter/material.dart';

import '../features/splash/splash_page.dart';
import '../features/home/home_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/admin/admin_dashboard.dart';
import '../features/user/user_dashboard.dart';
import '../features/courier/courier_dashboard.dart';
import '../features/admin/menu_page.dart';
import '../features/admin/order_page.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const admin = '/admin';
  static const user = '/user';
  static const courier = '/courier';
  static const menu = '/menu';
  static const orders = '/orders';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashPage(),
    home: (_) => const HomePage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    admin: (_) => const AdminDashboard(),
    menu: (_) => const MenuPage(),
    orders: (_) => const OrderPage(),
    user: (_) => const UserDashboard(),
    courier: (_) => const CourierDashboard(),
  };
}
