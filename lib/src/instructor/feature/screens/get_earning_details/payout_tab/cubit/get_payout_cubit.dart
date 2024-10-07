import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/api/get_payouts_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetPayoutsStatus { initial, loading, success, error }

class GetPayoutCubit extends Cubit<GetPayoutsState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;

  GetPayoutCubit() : super(const GetPayoutsState(GetPayoutsStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetPayoutsState(GetPayoutsStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getPayouts();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled due to logout');
    }
  }

  Future<void> getPayouts() async {
    if (_isClosed) return;

    emit(const GetPayoutsState(GetPayoutsStatus.loading));
    try {
      final plans = await GetPayoutsApi.getPayouts(cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          GetPayoutsState(
            GetPayoutsStatus.success,
            plans: plans,
          ),
        );
      }
    } on DioException catch (error) {
      if (_isClosed) return;
      if (error.type == DioExceptionType.cancel) {
        return; // Don't emit an error state if the request was canceled
      }
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'] ?? errorMessage;
      }
      emit(
        GetPayoutsState(
          GetPayoutsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        GetPayoutsState(
          GetPayoutsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _isClosed = true;
    cancelOngoingCalls();
    _connectivitySubscription.cancel();
    return super.close();
  }
}
