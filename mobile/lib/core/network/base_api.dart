import 'package:dio/dio.dart';
import 'package:tom_travel_app/data/datasources/local/auth_local_data_source.dart';
import 'api_service.dart';

class BaseApi {
  final Dio _dio = ApiService.dio;
  final AuthLocalDataSource _local = AuthLocalDataSource();

  BaseApi() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // جلب التوكن من التخزين المحلي
          final token = await _local.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  //               GET
  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return response; 
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  //               POST
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  //               PUT
  Future<Response> put(String endpoint, dynamic data) async {
  try {
    final response = await _dio.put(endpoint, data: data);
    return response;
  } on DioException catch (e) {
    throw Exception(_handleError(e));
  }
}


  //             DELETE
  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> putMultipart(String endpoint, FormData data) async {
  try {
    return await _dio.put(endpoint, data: data);
  } on DioException catch (e) {
    throw Exception(_handleError(e));
  }
}


  //        ERROR HANDLER
  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data.toString() ?? "Unknown server error";
    } else {
      return e.message ?? "Connection failed";
    }
  }
}
