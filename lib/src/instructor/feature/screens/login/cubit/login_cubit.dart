import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/login_api/login_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/models/login_models.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    // Initialize the connectivity subscription
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(LoginNoInternet());
      }
    });
  }

  userLogin(String phone) {
    emit(LoginLoading());
    LoginApi().userLogin(phone).then(
      (value) {
        emit(LoginSuccess(value!));
      },
    ).onError(
      (error, stackTrace) {
        emit(LoginError());
      },
    );
  }
}
