import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/get_plans_api/get_plans_api.dart';

enum GetPlansStatus { initial, loading, success, error }

class GetPlansCubit extends Cubit<GetPlansState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;

  GetPlansCubit() : super(const GetPlansState(GetPlansStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetPlansState(GetPlansStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getPlans();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled');
    }
  }

  Future<void> getPlans() async {
    if (_isClosed) return;

    emit(const GetPlansState(GetPlansStatus.loading));
    try {
      final plans = await GetPlansApi.getPlans(cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(GetPlansState(GetPlansStatus.success, plans: plans));
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
      emit(GetPlansState(GetPlansStatus.error, errorMessage: errorMessage));
    } catch (error) {
      if (_isClosed) return;
      emit(GetPlansState(GetPlansStatus.error, errorMessage: error.toString()));
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
