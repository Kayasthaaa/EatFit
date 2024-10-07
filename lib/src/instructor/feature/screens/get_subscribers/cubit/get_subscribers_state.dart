import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/models/get_subscribers_models.dart';

class GetSubscribersState {
  final GetSubscribersStatus status;
  final List<GetSubscribersModels>? subscribers;
  final String? errorMessage;

  const GetSubscribersState(this.status, {this.subscribers, this.errorMessage});
}
