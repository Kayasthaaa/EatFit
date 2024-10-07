import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';

class GetInvitationsState {
  final GetInvitationStatus status;
  final List<UserInvitationsModels>? plans;
  final String? errorMessage;

  const GetInvitationsState(this.status, {this.plans, this.errorMessage});
}
