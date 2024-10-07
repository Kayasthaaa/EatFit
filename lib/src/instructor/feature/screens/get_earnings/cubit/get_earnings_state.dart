import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/models/get_earnings_models.dart';

class GetEarningsState {
  final GetEarningsStatus status;
  final EarningsModels? earnings;
  final String? errorMessage;

  const GetEarningsState(this.status, {this.earnings, this.errorMessage});
}
