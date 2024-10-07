import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/cubit/get_plans_details_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/my_plan_details_api/my_plan_details_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetPlansDetailsStatus { initial, loading, success, error }

class GetPlansDetailsCubit extends Cubit<GetPlansDetailsState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final CancelToken _cancelToken = CancelToken();
  bool _isClosed = false;
  final int _id;

  GetPlansDetailsCubit(this._id)
      : super(const GetPlansDetailsState(GetPlansDetailsStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetPlansDetailsState(GetPlansDetailsStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getPlansDetails(id: _id);
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled');
    }
  }

  Future<void> getPlansDetails({required int id}) async {
    if (_isClosed) return;

    emit(const GetPlansDetailsState(GetPlansDetailsStatus.loading));
    try {
      final plans = await GetPlansDetailsApi.getPlansDetails(
          id: id, cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          GetPlansDetailsState(
            GetPlansDetailsStatus.success,
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
        GetPlansDetailsState(
          GetPlansDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        GetPlansDetailsState(
          GetPlansDetailsStatus.error,
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
