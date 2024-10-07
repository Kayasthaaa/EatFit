import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/api/user_subscriber_details_api.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/cubit/user_subscriber_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UsersubscriberDetailsStatus { initial, loading, success, error }

class UsersubscriberDetailsCubit extends Cubit<UsersubscriberDetailsState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;
  final int _id;

  UsersubscriberDetailsCubit(this._id)
      : super(const UsersubscriberDetailsState(
            UsersubscriberDetailsStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const UsersubscriberDetailsState(
              UsersubscriberDetailsStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getUserSubscriberDetails(id: _id);
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled');
    }
  }

  Future<void> getUserSubscriberDetails({required int id}) async {
    if (_isClosed) return;

    emit(const UsersubscriberDetailsState(UsersubscriberDetailsStatus.loading));
    try {
      final plans = await UserSubscriberDetailsApi.getUserSubscriberDetails(
          id: id, cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          UsersubscriberDetailsState(
            UsersubscriberDetailsStatus.success,
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
        UsersubscriberDetailsState(
          UsersubscriberDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        UsersubscriberDetailsState(
          UsersubscriberDetailsStatus.error,
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
