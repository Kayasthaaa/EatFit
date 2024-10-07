import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/models/get_payouts_models.dart';

class GetPayoutsState {
  final GetPayoutsStatus status;
  final List<GetPaymentModels>? plans;
  final String? errorMessage;

  const GetPayoutsState(this.status, {this.plans, this.errorMessage});
}
