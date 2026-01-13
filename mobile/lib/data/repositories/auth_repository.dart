import 'package:dio/dio.dart';
import 'package:tom_travel_app/core/network/base_api.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';
import 'package:tom_travel_app/data/datasources/local/auth_local_data_source.dart';
import 'package:tom_travel_app/data/models/user_model.dart';

class AuthResult {
  final UserModel user;
  final String token;

  AuthResult(this.user, this.token);
}

class AuthRepository {
  final BaseApi _api = BaseApi();
  final AuthLocalDataSource _local = AuthLocalDataSource();

  //             LOGIN
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.post('/login', {
      'email': email,
      'password': password,
    });

    final user = UserModel.fromJson(response.data['user']);
    final token = response.data['token'];

    // حفظ الجلسة
    await _local.saveToken(token);

    return AuthResult(user, token);
  }


  //             REGISTER
   Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    final response = await _api.post('/register', {
      'name': name,
      'email': email,
      'password': password,
      if (phone != null) 'phone': phone,
    });

    final user = UserModel.fromJson(response.data['user']);
    final token = response.data['token'];

    await _local.saveToken(token);

    return AuthResult(user, token);
  }


Future<UserModel> updateProfile({
  required String name,
  required String email,
  String? phone,
  String? imagePath,
}) async {
  FormData formData = FormData.fromMap({
    'name': name,
    'email': email,
    if (phone != null) 'phone': phone,
    if (imagePath != null)
      'profile_image': await MultipartFile.fromFile(imagePath),
    '_method': 'PUT',
  });

  final response = await DioClient().post(
    '/profile',
    data: formData,
  );

  return UserModel.fromJson(response.data['user']);
}


  Future<String?> getSavedToken() async {
    return await _local.getToken();
  }

  Future<void> logout() async {
  await _local.clearToken();
}

}
