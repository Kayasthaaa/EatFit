// import 'package:dio/dio.dart';
// import 'package:eat_fit/src/instructor/feature/screens/fcm_token/api/fcm_token_api.dart';
// import 'package:eat_fit/src/instructor/feature/screens/fcm_token/cubit/fcm_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// enum FCMStatus { initial, loading, success, error }

// class FCMCubit extends Cubit<FCMState> {
//   FCMCubit() : super(const FCMState(FCMStatus.initial));

//   Future<void> postFcm() async {
//     if (state.status == FCMStatus.loading) {
//       return; // Prevents multiple simultaneous requests
//     }
//     emit(const FCMState(FCMStatus.loading));

//     try {
//       final plans = await FCMApiClass.postFcm();
//       emit(
//         FCMState(
//           FCMStatus.success,
//           plans: plans,
//         ),
//       );
//     } on DioException catch (error) {
//       if (error.response != null) {
//         // Server returned an error response
//         final errorMessage =
//             error.response!.data['error'] ?? 'Error, Please try again';

//         emit(
//           FCMState(
//             FCMStatus.error,
//             errorMessage: errorMessage,
//           ),
//         );
//       } else if (error.type == DioExceptionType.receiveTimeout) {
//         // Timeout error
//         emit(
//           const FCMState(
//             FCMStatus.error,
//             errorMessage: 'Request timed out',
//           ),
//         );
//       } else {
//         // Other Dio errors (e.g., network errors)
//         emit(
//           FCMState(
//             FCMStatus.error,
//             errorMessage: 'Network error: ${error.message}',
//           ),
//         );
//       }
//     } catch (error) {
//       // Other exceptions
//       emit(
//         FCMState(
//           FCMStatus.error,
//           errorMessage: error.toString(),
//         ),
//       );
//     }
//   }
// }
