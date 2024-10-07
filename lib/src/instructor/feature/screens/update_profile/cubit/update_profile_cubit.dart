import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/api/update_profile_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/cubit/update_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UpdateProfileStatus { initial, loading, success, error }

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit()
      : super(const UpdateProfileState(UpdateProfileStatus.initial));

  Future<void> updateProfile(String name, String bio, File? image) async {
    if (state.status == UpdateProfileStatus.loading) {
      return; // Prevents multiple simultaneous requests
    }
    emit(const UpdateProfileState(UpdateProfileStatus.loading));

    try {
      final plans = await UpdateProfileApiClass.updateProfile(name, bio, image);
      emit(
        UpdateProfileState(
          UpdateProfileStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // Server returned an error response
        final errorMessage =
            error.response!.data['error'] ?? 'Error, Please try again';
        emit(
          UpdateProfileState(
            UpdateProfileStatus.error,
            errorMessage: errorMessage,
          ),
        );
      } else if (error.type == DioExceptionType.receiveTimeout) {
        // Timeout error
        emit(
          const UpdateProfileState(
            UpdateProfileStatus.error,
            errorMessage: 'Request timed out',
          ),
        );
      } else {
        // Other Dio errors (e.g., network errors)
        emit(
          UpdateProfileState(
            UpdateProfileStatus.error,
            errorMessage: 'Network error: ${error.message}',
          ),
        );
      }
    } catch (error) {
      // Other exceptions
      emit(
        UpdateProfileState(
          UpdateProfileStatus.error,
          errorMessage: 'Unexpected error: ${error.toString()}',
        ),
      );
    }
  }
}
