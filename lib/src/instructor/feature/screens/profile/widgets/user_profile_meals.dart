import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/screen/page/user_subscriber_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_state.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/fancy_texts.dart';
import 'package:eat_fit/src/user/feature/screen/my_meal_plans/widget/user_meal_container.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UserMealPlansProfilePage extends StatelessWidget {
  const UserMealPlansProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSubscribersCubit()..getSubscribers(),
      child: BlocBuilder<GetSubscribersCubit, GetSubscribersState>(
        builder: (context, state) {
          if (state.status == GetSubscribersStatus.success) {
            final sub = state.subscribers;
            return sub!.isEmpty
                ? const Column(
                    children: [
                      SizedBox(height: 250),
                      Center(
                        child: FancyText(),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: maxWidth(context),
                          child: const Texts(
                            texts: 'My Meal Plans',
                            color: AppColor.kTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: sub.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, int index) {
                            // Parse created_at from the API
                            DateTime createdAt =
                                DateTime.parse(sub[index].createdAt!);
                            int mealTimes = sub[index].mealPlan!.numberOfDays!;

                            // Reset the time component of the dates to 00:00:00
                            DateTime createdAtDate = DateTime(
                                createdAt.year, createdAt.month, createdAt.day);
                            DateTime now = DateTime.now();
                            DateTime nowDate =
                                DateTime(now.year, now.month, now.day);

                            // Calculate the progress
                            final daysPassed =
                                nowDate.difference(createdAtDate).inDays;
                            final progress =
                                (daysPassed / mealTimes).clamp(0.0, 1.0);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: UserMealContainer(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: UserSubscriberDetailsPage(
                                      id: sub[index].id!,
                                      firstW: sub[index].mealPlan!.planName!,
                                      mealName: sub[index].mealPlan!.planName!,
                                      name: sub[index].instructorName ?? '',
                                    ),
                                    withNavBar: true,
                                  );
                                },
                                margin: const EdgeInsets.all(0),
                                created: sub[index].createdAt!,
                                planName:
                                    sub[index].mealPlan!.planName.toString(),
                                numberOfDays: sub[index]
                                    .mealPlan!
                                    .numberOfDays
                                    .toString(),
                                firstWord:
                                    sub[index].mealPlan!.planName.toString(),
                                url: sub[index].instructorPicture ?? '',
                                instructor: sub[index].instructorName ?? '',
                                time: sub[index]
                                    .mealPlan!
                                    .numberOfDays
                                    .toString(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(7),
                                      value: progress,
                                      backgroundColor: Colors.grey[200],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
