import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/models/get_my_plans_models.dart';

class GetPlansState {
  final GetPlansStatus status;
  final List<GetPlansModels>? plans;
  final String? errorMessage;

  const GetPlansState(this.status, {this.plans, this.errorMessage});
}
