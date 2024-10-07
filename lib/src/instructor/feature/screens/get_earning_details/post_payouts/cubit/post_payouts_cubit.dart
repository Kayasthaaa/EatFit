import 'package:dio/dio.dart';
import 'dart:developer' as print;
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/api/post_payout_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/cubit/post_payouts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PostPayoutStatus { initial, loading, success, error }

class PostPayoutCubit extends Cubit<PostPayoutState> {
  PostPayoutCubit() : super(const PostPayoutState(PostPayoutStatus.initial));

  Future<void> postPayout(String amount) async {
    if (state.status == PostPayoutStatus.loading) {
      return; // Prevents multiple simultaneous requests
    }
    emit(const PostPayoutState(PostPayoutStatus.loading));

    try {
      final plans = await PostPayoutApiClass.postPayout(amount);
      emit(
        PostPayoutState(
          PostPayoutStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // Server returned an error response
        final errorMessage =
            error.response!.data['error'] ?? 'Error, Please try again';
        emit(
          PostPayoutState(
            PostPayoutStatus.error,
            errorMessage: errorMessage,
          ),
        );
      } else if (error.type == DioExceptionType.receiveTimeout) {
        // Timeout error
        emit(
          const PostPayoutState(
            PostPayoutStatus.error,
            errorMessage: 'Request timed out',
          ),
        );
      } else {
        // Other Dio errors (e.g., network errors)
        emit(
          PostPayoutState(
            PostPayoutStatus.error,
            errorMessage: 'Network error: ${error.message}',
          ),
        );
      }
    } catch (error) {
      if (error is DioException) {
        if (error.response != null) {
          final errorResponse = error.response!.data;
          print.log('Error Response: $errorResponse');

          if (errorResponse != null && errorResponse is Map<String, dynamic>) {
            final errorMessage =
                errorResponse['msg'] ?? 'Error, Please try again';
            emit(PostPayoutState(PostPayoutStatus.error,
                errorMessage: errorMessage));
          } else {
            emit(const PostPayoutState(PostPayoutStatus.error,
                errorMessage: 'Invalid error response format'));
          }
        } else if (error.type == DioExceptionType.receiveTimeout) {
          emit(const PostPayoutState(PostPayoutStatus.error,
              errorMessage: 'Request timed out'));
        } else {
          emit(PostPayoutState(PostPayoutStatus.error,
              errorMessage: 'Network error: ${error.message}'));
        }
      } else if (error is Exception) {
        // Remove the "Exception:" prefix
        final errorMessage = error.toString().replaceAll('Exception: ', '');
        emit(PostPayoutState(PostPayoutStatus.error,
            errorMessage: errorMessage));
      }
    }
  }
}
