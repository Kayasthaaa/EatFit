part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModels loginModels;
  LoginSuccess(this.loginModels);
}

class LoginError extends LoginState {}

class LoginNoInternet extends LoginState {}
