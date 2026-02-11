import '../network/dio_client.dart';
import '../storage/token_storage.dart';

class AuthService {
  static Future<String> register({
  required String username,
  required String email,
  required String password,
  required String role,
}) async {
  await DioClient.client.post(
    '/auth/register',
    data: {
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    },
  );

  // AUTO LOGIN
  final loginResponse = await DioClient.client.post(
    '/auth/login',
    data: {
      'email': email,
      'password': password,
    },
  );

  final token = loginResponse.data['token'];
  final userRole = loginResponse.data['user']['role'];

  await TokenStorage.saveToken(token);

  return userRole;
}


  static Future<String> login({
  required String email,
  required String password,
}) async {
  final response = await DioClient.client.post(
    '/auth/login',
    data: {
      'email': email,
      'password': password,
    },
  );

  print('LOGIN RESPONSE: ${response.data}');

  final data = response.data;

  final token = data['token'] ?? data['access_token'];
  if (token == null) {
    throw Exception('TOKEN NULL');
  }

  await TokenStorage.saveToken(token);

  String? role;
  if (data['user'] != null) {
    role = data['user']['role'];
  } else if (data['role'] != null) {
    role = data['role'];
  }

  if (role == null) {
    throw Exception('ROLE NULL');
  }

  return role;
}


  static Future<void> logout() async {
    await DioClient.client.post('/auth/logout');
    await TokenStorage.clearToken();
  }

  // ✅ INI YANG KURANG
  static Future<String> getRole() async {
    final response = await DioClient.client.get('/profile');
    return response.data['data']['role'];
  }
}
