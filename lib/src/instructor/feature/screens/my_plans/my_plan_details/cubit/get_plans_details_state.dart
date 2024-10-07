import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/cubit/get_plans_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/models/get_my_plans_models.dart';

class GetPlansDetailsState {
  final GetPlansDetailsStatus status;
  final GetPlansModels? plans;
  final String? errorMessage;

  const GetPlansDetailsState(this.status, {this.plans, this.errorMessage});
}
