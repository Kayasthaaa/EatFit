// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/user/feature/screen/subscribe_meal_plan/screen/subscribe_meal_plan.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';
import 'package:flutter/material.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/widgets/user_meal_container.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:readmore/readmore.dart';

class MealPlanContent extends StatelessWidget {
  final UserMealDetailsModels _plan;
  final UserInvitationsModels models;

  const MealPlanContent(
    this._plan, {
    super.key,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            width: maxWidth(context),
            child: Texts(
              texts: 'Meal Plan Invitations',
              color: AppColor.kTitleColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 10),
          UserContainer(
            created: _plan.modifiedAt.toString(),
            planName: _plan.planName.toString(),
            numberOfDays: _plan.numberOfDays.toString(),
            price: _plan.price.toString(),
            firstWord: _plan.planName.toString(),
            remainingDays: models.expiresAt.toString(),
            url: _plan.instructorPicture ?? '',
            instructor: _plan.instructorName ?? 'Instructor',
            time: _plan.mealTimes!.length.toString(),
            subTop: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SubscribeMealPlanePage(
                  inv: models,
                  models: _plan,
                ),
                withNavBar: true,
              );
            },
          ),
          SizedBox(height: 20),
          _buildMealPlanList(context, _plan),
          SizedBox(height: 5),
          Containers(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SubscribeMealPlanePage(
                  inv: models,
                  models: _plan,
                ),
                withNavBar: true,
              );
            },
            width: maxWidth(context),
            child: Center(
              child: Texts(
                texts: 'SUBSCRIBE TO SEE ALL MENU',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(234, 93, 36, 1),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMealPlanList(BuildContext context, UserMealDetailsModels _plan) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _plan.meals!.length,
      itemBuilder: (_, int index) {
        return _buildMealPlanCard(context, _plan, index);
      },
    );
  }

  Widget _buildMealPlanCard(
      BuildContext context, UserMealDetailsModels _plan, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Containers(
        width: maxWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            ),
          ],
          border: Border.all(
            width: 1.0,
            color: const Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Texts(
                texts: 'DAY ${_plan.meals![index].day}',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(234, 93, 36, 1),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _plan.meals![index].dayMeals!.length,
                itemBuilder: (_, int secIndx) {
                  final _data = _plan.meals![index].dayMeals;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Texts(
                        texts: _data![secIndx].time.toString(),
                        overflow: TextOverflow.ellipsis,
                        color: const Color.fromRGBO(183, 183, 183, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      ReadMoreText(
                        _data[secIndx].description.toString(),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
