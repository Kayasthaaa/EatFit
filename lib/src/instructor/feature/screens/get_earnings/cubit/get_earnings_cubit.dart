import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/api/get_earnings_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetEarningsStatus { initial, loading, success, error }

class GetEarningsCubit extends Cubit<GetEarningsState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;

  GetEarningsCubit()
      : super(const GetEarningsState(GetEarningsStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetEarningsState(GetEarningsStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getEarnings();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled due to logout');
    }
  }

  Future<void> getEarnings() async {
    if (_isClosed) return;

    emit(const GetEarningsState(GetEarningsStatus.loading));
    try {
      final earnings =
          await GetEarningsApi.getEarnings(cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          GetEarningsState(
            GetEarningsStatus.success,
            earnings: earnings,
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
        GetEarningsState(
          GetEarningsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        GetEarningsState(
          GetEarningsStatus.error,
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
