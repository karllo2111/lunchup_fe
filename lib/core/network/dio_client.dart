import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../../config/api_config.dart';

class DioClient {
  static final Dio client = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
}
