import 'package:eat_fit/src/instructor/feature/screens/generate_code/cubit/generate_code_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/models/generate_code_models.dart';

class GenerateCodeState {
  final GenerateCodeStatus status;
  final GenerateCodeModels? plans;
  final String? errorMessage;

  const GenerateCodeState(this.status, {this.plans, this.errorMessage});
}
