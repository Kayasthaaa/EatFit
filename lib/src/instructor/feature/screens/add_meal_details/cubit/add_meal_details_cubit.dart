import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/api/add_meal_details_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/cubit/add_meal_details_state.dart';

enum AddMealPlanStatus { initial, loading, success, error }

class AddMealPlanCubit extends Cubit<AddMealPlanState> {
  AddMealPlanCubit() : super(const AddMealPlanState(AddMealPlanStatus.initial));

  Future<void> addMealPlan(Map<String, dynamic> payload) async {
    emit(const AddMealPlanState(AddMealPlanStatus.loading));
    try {
      final response = await AddMealPlanApi.addMealPlan(payload);
      emit(AddMealPlanState(AddMealPlanStatus.success, response: response));
    } on DioException catch (error) {
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'];
      }
      emit(AddMealPlanState(AddMealPlanStatus.error,
          errorMessage: errorMessage));
    } catch (error) {
      emit(AddMealPlanState(AddMealPlanStatus.error,
          errorMessage: error.toString()));
    }
  }
}
