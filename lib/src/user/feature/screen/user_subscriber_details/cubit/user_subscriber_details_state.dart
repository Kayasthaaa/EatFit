import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/cubit/user_subscriber_details_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/models/user_subscriber_details_models.dart';

class UsersubscriberDetailsState {
  final UsersubscriberDetailsStatus status;
  final List<SubscriberDetailsModels>? plans;
  final String? errorMessage;

  const UsersubscriberDetailsState(this.status,
      {this.plans, this.errorMessage});
}
