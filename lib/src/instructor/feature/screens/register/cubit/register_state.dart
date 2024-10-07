part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegsiterInitial extends RegisterState {}

class RegsiterLoading extends RegisterState {}

class RegsiterSuccess extends RegisterState {
  final RegisterModels registerModels;
  RegsiterSuccess(this.registerModels);
}

class RegsiterError extends RegisterState {
  final String errorMessage;
  RegsiterError(this.errorMessage);
}

class RegsiterNoInternet extends RegisterState {}
