import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/models/profile_models.dart';

class GetProfileDetailsState {
  final GetProfileDetailsStatus status;
  final ProfileModels? plans;
  final String? errorMessage;

  const GetProfileDetailsState(this.status, {this.plans, this.errorMessage});
}
