import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';
import 'package:tom_travel_app/data/repositories/auth_repository.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';

// أدارة الحالات لتسجيل الدخول
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  String? _savedToken;


  AuthCubit(this._repo) : super(AuthInitial());

Future<void> login(String email, String password) async {
  emit(AuthLoading());
  try {
    final result = await _repo.login(email: email, password: password);

    _savedToken = result.token; 
    DioClient().setAuthToken(_savedToken!);

    emit(AuthSuccess(result.user, _savedToken!));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}


Future<void> register(String name, String email, String password, String phone) async {
  emit(AuthLoading());
  try {
    final result = await _repo.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
    _savedToken = result.token; 
    DioClient().setAuthToken(result.token);

    emit(AuthSuccess(result.user, result.token));

  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}


Future<void> updateProfile({
  required String name,
  required String email,
  String? phone,
  String? imagePath,
}) async {
  emit(AuthLoading());

  try {
    if (_savedToken == null) {
      emit(AuthFailure("Missing token"));
      return;
    }
    DioClient().setAuthToken(_savedToken!);

    final updatedUser = await _repo.updateProfile(
      name: name,
      email: email,
      phone: phone,
      imagePath: imagePath,
    );

    emit(AuthSuccess(updatedUser, _savedToken!));

  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}


  Future<void> logout() async {
  await _repo.logout();
  emit(AuthInitial());
}

}