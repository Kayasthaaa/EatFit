import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/api_class/generate_api_class.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/cubit/generate_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GenerateCodeStatus { initial, loading, success, error }

class GenerateCodeCubit extends Cubit<GenerateCodeState> {
  GenerateCodeCubit()
      : super(const GenerateCodeState(GenerateCodeStatus.initial));

  Future<void> postCode(String meal, String phone) async {
    if (state.status == GenerateCodeStatus.loading) {
      return; // Prevents multiple simultaneous requests
    }
    emit(const GenerateCodeState(GenerateCodeStatus.loading));

    try {
      final plans = await GenerateApiClass.postCode(meal, phone);
      emit(
        GenerateCodeState(
          GenerateCodeStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // Server returned an error response
        final errorMessage =
            error.response!.data['error'] ?? 'Error, Please try again';

        emit(
          GenerateCodeState(
            GenerateCodeStatus.error,
            errorMessage: errorMessage,
          ),
        );
      } else if (error.type == DioExceptionType.receiveTimeout) {
        // Timeout error
        emit(
          const GenerateCodeState(
            GenerateCodeStatus.error,
            errorMessage: 'Request timed out',
          ),
        );
      } else {
        // Other Dio errors (e.g., network errors)
        emit(
          GenerateCodeState(
            GenerateCodeStatus.error,
            errorMessage: 'Network error: ${error.message}',
          ),
        );
      }
    } catch (error) {
      // Other exceptions
      emit(
        GenerateCodeState(
          GenerateCodeStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
