import 'package:eat_fit/src/instructor/feature/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/models/profile_update_models.dart';

class UpdateProfileState {
  final UpdateProfileStatus status;
  final ProfileUpdate? plans;
  final String? errorMessage;

  const UpdateProfileState(this.status, {this.plans, this.errorMessage});
}
