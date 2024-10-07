import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/api/get_earnings_details_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/models/earning_details_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetEarningsDetailsStatus { initial, loading, success, error }

class GetEarningDetailsCubit extends Cubit<GetEarningsDetailsState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isClosed = false;
  final CancelToken _cancelToken = CancelToken();

  GetEarningDetailsCubit()
      : super(const GetEarningsDetailsState(GetEarningsDetailsStatus.initial)) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(const GetEarningsDetailsState(GetEarningsDetailsStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          getEarningDetails();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled due to logout');
    }
  }

  Future<void> getEarningDetails() async {
    if (_isClosed) return;

    emit(const GetEarningsDetailsState(GetEarningsDetailsStatus.loading));
    try {
      final List<EarningDetailsModel> plans =
          await GetEarningDetailsApi.getEarningDetails(
              cancelToken: _cancelToken);
      if (!_isClosed) {
        emit(
          GetEarningsDetailsState(
            GetEarningsDetailsStatus.success,
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
        GetEarningsDetailsState(
          GetEarningsDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      if (_isClosed) return;
      emit(
        GetEarningsDetailsState(
          GetEarningsDetailsStatus.error,
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
