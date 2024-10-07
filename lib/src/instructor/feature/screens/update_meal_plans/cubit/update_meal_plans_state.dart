import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/cubit/update_meal_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/models/update_meal_plans_models.dart';

class UpdateMealDetailsState {
  final UpdateMealDetailsStatus status;
  final UpdateMealPlans? plans;
  final String? errorMessage;

  const UpdateMealDetailsState(this.status, {this.plans, this.errorMessage});
}
