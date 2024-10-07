// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/page/in_app_notification.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class kAppBar extends StatelessWidget {
  const kAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Containers(
          height: 46,
          width: 79,
          child: Image.asset(
            'images/eatfitlogo.png',
            //fit: BoxFit.fill,
          ),
        ),
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            int unreadCount =
                state.notifications?.where((n) => !n.seen).length ?? 0;

            return GestureDetector(
              onTap: () async {
                await context
                    .read<NotificationCubit>()
                    .markAllNotificationsAsSeen();

                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const InAppNotification(),
                  withNavBar: true,
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Containers(
                    height: 25,
                    width: 22,
                    child: Image.asset(
                      'images/vector.png',
                      //fit: BoxFit.fill,
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Center(
                          child: Text(
                            unreadCount > 99 ? '99+' : '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
