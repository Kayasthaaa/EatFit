import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/cubit/add_meal_details_cubit.dart';

class AddMealPlanState {
  final AddMealPlanStatus status;
  final dynamic response;
  final String? errorMessage;

  const AddMealPlanState(this.status, {this.response, this.errorMessage});
}
