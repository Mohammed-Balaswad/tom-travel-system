import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.0.109:8000/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;

  // إضافة الـ Token في الهيدر عند تسجيل الدخول
  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // إزالة الـ Token عند تسجيل الخروج
  static void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}
