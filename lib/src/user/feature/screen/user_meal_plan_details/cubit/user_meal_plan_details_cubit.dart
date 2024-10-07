import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/api/user_meal_plan_details_api.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/cubit/user_meal_plan_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetUserPlansDetailsStatus { initial, loading, success, error }

class GetUserPlansDetailsCubit extends Cubit<GetUserPlansDetailsState> {
  GetUserPlansDetailsCubit(int id)
      : super(
            const GetUserPlansDetailsState(GetUserPlansDetailsStatus.initial)) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(const GetUserPlansDetailsState(GetUserPlansDetailsStatus.error,
            errorMessage: 'No internet connection'));
      } else {
        getUserPlansDetails(id: id);
      }
    });
  }

  Future<void> getUserPlansDetails({required int id}) async {
    emit(const GetUserPlansDetailsState(GetUserPlansDetailsStatus.loading));
    try {
      final plans = await GetUserPlansDetailsApi.getUserPlansDetails(id: id);
      emit(
        GetUserPlansDetailsState(
          GetUserPlansDetailsStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'];
      }
      emit(
        GetUserPlansDetailsState(
          GetUserPlansDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      emit(
        GetUserPlansDetailsState(
          GetUserPlansDetailsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
