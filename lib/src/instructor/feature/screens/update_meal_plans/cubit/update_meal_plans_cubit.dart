import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/api/update_meal_plans_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/cubit/update_meal_plans_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UpdateMealDetailsStatus { initial, loading, success, error }

class UpdatePlansDetailsCubit extends Cubit<UpdateMealDetailsState> {
  UpdatePlansDetailsCubit(String name, int id)
      : super(const UpdateMealDetailsState(UpdateMealDetailsStatus.initial)) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(const UpdateMealDetailsState(UpdateMealDetailsStatus.error,
            errorMessage: 'No internet connection'));
      } else {
        updateMealDetails(name: name, id: id);
      }
    });
  }

  Future<void> updateMealDetails(
      {required String name, required int id}) async {
    emit(const UpdateMealDetailsState(UpdateMealDetailsStatus.loading));
    try {
      final plans =
          await UpdateMealDetailsApiClass.updateMealDetails(name: name, id: id);
      emit(
        UpdateMealDetailsState(
          UpdateMealDetailsStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'];
      }
      emit(
        UpdateMealDetailsState(
          UpdateMealDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      emit(
        UpdateMealDetailsState(
          UpdateMealDetailsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
