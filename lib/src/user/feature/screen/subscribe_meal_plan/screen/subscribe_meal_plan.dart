import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/user/feature/screen/google_map_integration/screen/googel_maps.dart';
import 'package:eat_fit/src/user/feature/screen/subscribe_meal_plan/widget/sub_widget.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../instructor/feature/widgets/app_bar.dart';

class SubscribeMealPlanePage extends StatelessWidget {
  final UserMealDetailsModels models;
  final UserInvitationsModels inv;
  const SubscribeMealPlanePage(
      {super.key, required this.models, required this.inv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: maxWidth(context),
              child: const Texts(
                texts: 'Subscribe Meal Plan',
                color: AppColor.kTitleColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10),
            SubContainer(
              created: models.modifiedAt!,
              planName: models.planName!,
              numberOfDays: models.numberOfDays.toString(),
              price: models.price!,
              firstWord: models.planName!,
              remainingDays: inv.expiresAt!,
              url: models.instructorPicture ?? '',
              instructor: models.instructorName ?? 'Instructor',
              time: models.mealTimes!.length.toString(),
            ),
            const SizedBox(height: 20),
            const Texts(
              texts: 'Delivery Details',
              color: AppColor.kTitleColor,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
            const SizedBox(height: 10),
            const Texts(
              texts: 'Set Delivery Location',
              color: Color.fromRGBO(104, 104, 104, 1),
              fontWeight: FontWeight.w400,
              fontSize: 9,
            ),
            const SizedBox(height: 10),
            Containers(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: GoogleMapsPage(
                    models: models,
                    inv: inv,
                  ),
                  withNavBar: true,
                );
              },
              height: 310,
              width: maxWidth(context),
              child: Image.asset(
                'images/map.png',
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
