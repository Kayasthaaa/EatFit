import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/cubit/post_payouts_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/models/post_payouts_models.dart';

class PostPayoutState {
  final PostPayoutStatus status;
  final PostPayoutModels? plans;
  final String? errorMessage;

  const PostPayoutState(this.status, {this.plans, this.errorMessage});
}
