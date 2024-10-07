import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/api/user_invitations_api.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetInvitationStatus { initial, loading, success, error }

class GetInvitationsCubit extends Cubit<GetInvitationsState> {
  GetInvitationsCubit()
      : super(const GetInvitationsState(GetInvitationStatus.initial)) {
    // Initialize the connectivity subscription
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          emit(const GetInvitationsState(GetInvitationStatus.error,
              errorMessage: 'No internet connection'));
        } else {
          // Reload plans when internet connection is restored
          getInvitations();
        }
      },
    );
  }

  Future<void> getInvitations() async {
    emit(const GetInvitationsState(GetInvitationStatus.loading));
    try {
      final plans = await GetUserInvitationsApi.getInvitations();
      emit(
        GetInvitationsState(
          GetInvitationStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'];
      }
      emit(
        GetInvitationsState(
          GetInvitationStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      emit(
        GetInvitationsState(
          GetInvitationStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
