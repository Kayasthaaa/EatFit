import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/feature/screens/register/api/register_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/register/models/register_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegsiterInitial()) {
    // Initialize the connectivity subscription
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(RegsiterNoInternet());
      }
    });
  }

  registerUser(phone, password, confirmPassword) {
    emit(RegsiterLoading());
    RegisterUserApi().registerUser(phone, password, confirmPassword).then(
      (value) {
        if (value != null) {
          emit(RegsiterSuccess(value));
        } else {
          emit(RegsiterError(
              'Registration failed. Please try again.')); // Emit RegsiterError with error message
        }
      },
    ).onError(
      (error, stackTrace) {
        emit(RegsiterError('$error')); // Emit RegsiterError with error message
      },
    );
  }
}
