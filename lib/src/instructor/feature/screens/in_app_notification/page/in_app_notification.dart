import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/widgets/notification_list.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

class InAppNotification extends StatelessWidget {
  const InAppNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: maxWidth(context),
          width: maxWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Containers(
                height: 46,
                width: 79,
                child: Image.asset(
                  'images/eatfitlogo.png',
                  //fit: BoxFit.fill,
                ),
              ),
              const SizedBox.shrink()
            ],
          ),
        ),
      ),
      body: const NotificationList(),
    );
  }
}

double maxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
