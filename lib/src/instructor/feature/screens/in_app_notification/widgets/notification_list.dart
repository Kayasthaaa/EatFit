import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/models/in_app_model.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/page/in_app_notification.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/widgets/notification_item.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state.status == NotificationStatus.loading) {
          return Center(
            child: AppLoading(),
          );
        }

        if (state.status == NotificationStatus.error) {
          return Center(
            child: Text(state.errorMessage ?? "An error occurred"),
          );
        }

        List<NotificationModel> notifications = state.notifications ?? [];

        if (notifications.isEmpty) {
          return const Center(
              child: Texts(
            texts: "No notifications",
            color: Colors.black,
            fontSize: 28,
          ));
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<NotificationCubit>().getNotifications();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      width: maxWidth(context),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Texts(
                            texts: 'My Notifications',
                            color: AppColor.kTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return NotificationItem(notification: notifications[index]);
                  },
                  childCount: notifications.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
