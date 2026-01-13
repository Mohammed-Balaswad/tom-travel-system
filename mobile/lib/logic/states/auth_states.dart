import 'package:tom_travel_app/data/models/user_model.dart';

abstract class AuthState {}

// حالات تسجيل الدخول
class AuthInitial extends AuthState {} 

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  final String token;

  AuthSuccess(this.user, this.token);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}