import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/feature/screens/redeem_code/api/redeem_code_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/redeem_code/models/redeem_code_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'redeem_code_state.dart';

class RedeemCodeCubit extends Cubit<RedeemCodeState> {
  RedeemCodeCubit() : super(RedeemCodeInitial()) {
    // Initialize the connectivity subscription
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(RedeemCodeNoInternet());
      }
    });
  }

  redeemCode(String inviteCode) {
    emit(RedeemCodeLoading());
    RedeemCodeApi().redeemCode(inviteCode).then(
      (value) {
        emit(RedeemCodeSuccess(value!));
      },
    ).onError(
      (error, stackTrace) {
        emit(RedeemCodeError());
      },
    );
  }
}
