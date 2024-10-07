import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/models/earning_details_models.dart';

class GetEarningsDetailsState {
  final GetEarningsDetailsStatus status;
  final List<EarningDetailsModel>? plans;
  final String? errorMessage;

  const GetEarningsDetailsState(this.status, {this.plans, this.errorMessage});
}
