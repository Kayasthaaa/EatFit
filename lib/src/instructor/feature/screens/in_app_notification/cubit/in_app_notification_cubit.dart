import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/api/in_app_api.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/models/in_app_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCubit extends Cubit<NotificationState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isClosed = false;
  final CancelToken _cancelToken = CancelToken();

  NotificationCubit() : super(const NotificationState()) {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_isClosed) {
        if (result == ConnectivityResult.none) {
          emit(state.copyWith(
            status: NotificationStatus.error,
            errorMessage: 'No internet connection',
          ));
        } else {
          getNotifications();
        }
      }
    });
  }

  void cancelOngoingCalls() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Operation canceled');
    }
  }

  Future<void> getNotifications() async {
    if (_isClosed) return;

    emit(state.copyWith(status: NotificationStatus.loading));
    try {
      final List<dynamic> rawNotifications =
          await NotificationApi.getNotifications(cancelToken: _cancelToken);

      final List<NotificationModel> notifications = rawNotifications
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      // Load seen status from SharedPreferences
      final boleanSeen = await SharedPreferences.getInstance();
      for (var i = 0; i < notifications.length; i++) {
        bool seen =
            boleanSeen.getBool('notification_${notifications[i].id}_seen') ??
                false;
        notifications[i] = notifications[i].copyWith(seen: seen);
      }

      if (!_isClosed) {
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
        ));
      }
    } catch (error) {
      if (_isClosed) return;
      emit(state.copyWith(
        status: NotificationStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> markAllNotificationsAsSeen() async {
    if (_isClosed || state.notifications == null) return;

    try {
      final boleanSeen = await SharedPreferences.getInstance();
      final updatedNotifications = state.notifications!.map((notification) {
        boleanSeen.setBool('notification_${notification.id}_seen', true);
        return notification.copyWith(seen: true);
      }).toList();

      emit(state.copyWith(
        notifications: updatedNotifications,
      ));
    } catch (error) {
      // Handle error
    }
  }

  @override
  Future<void> close() {
    _isClosed = true;
    cancelOngoingCalls();
    _connectivitySubscription.cancel();
    return super.close();
  }
}
