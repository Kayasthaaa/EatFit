import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/api/profile_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GetProfileDetailsStatus { initial, loading, success, error }

class GetProfileDetailsCubit extends Cubit<GetProfileDetailsState> {
  GetProfileDetailsCubit(int id)
      : super(const GetProfileDetailsState(GetProfileDetailsStatus.initial)) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(const GetProfileDetailsState(GetProfileDetailsStatus.error,
            errorMessage: 'No internet connection'));
      } else {
        getProfileDetails(id: id);
      }
    });
  }

  Future<void> getProfileDetails({required int id}) async {
    emit(const GetProfileDetailsState(GetProfileDetailsStatus.loading));
    try {
      final plans = await GetProfileDetailsApi.getProfileDetails(id: id);
      emit(
        GetProfileDetailsState(
          GetProfileDetailsStatus.success,
          plans: plans,
        ),
      );
    } on DioException catch (error) {
      String errorMessage = 'Error, Please try again';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['detail'];
      }
      emit(
        GetProfileDetailsState(
          GetProfileDetailsStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (error) {
      emit(
        GetProfileDetailsState(
          GetProfileDetailsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
