import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/cubit/user_meal_plan_details_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';

class GetUserPlansDetailsState {
  final GetUserPlansDetailsStatus status;
  final UserMealDetailsModels? plans;
  final String? errorMessage;

  const GetUserPlansDetailsState(this.status, {this.plans, this.errorMessage});
}
