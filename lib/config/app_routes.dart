import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/admin/admin_dashboard.dart';
import '../features/user/user_dashboard.dart';
import '../features/courier/courier_dashboard.dart';

class AppRoutes {
  static final routes = {
    '/login': (_) => const LoginPage(),
    '/register': (_) => const RegisterPage(),

    // ROLE BASED
    '/admin': (_) => const AdminDashboard(),
    '/user': (_) => const UserDashboard(),
    '/courier': (_) => const CourierDashboard(),
  };
}
