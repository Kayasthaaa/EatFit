import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/api/get_subscribers_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_state.dart';

enum GetSubscribersStatus { initial, loading, success, error }

class GetSubscribersCubit extends Cubit<GetSubscribersState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;

  GetSubscribersCubit()
      : super(const GetSubscribersState(GetSubscribersStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetSubscribersState(GetSubscribersStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getSubscribers();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled due to logout');
    }
  }

  Future<void> getSubscribers() async {
    if (_isClosed) return;

    emit(const GetSubscribersState(GetSubscribersStatus.loading));
    try {
      final subscribers =
          await GetSubscribersApi.getSubscribers(cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          GetSubscribersState(
            GetSubscribersStatus.success,
            subscribers: subscribers,
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
        GetSubscribersState(
          GetSubscribersStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        GetSubscribersState(
          GetSubscribersStatus.error,
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
