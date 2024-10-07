// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/fancy_texts.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_state.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/widgets/user_plan_container.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/screen/user_meal_plan_details.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UserMealInvitation extends StatelessWidget {
  final VoidCallback? onBackButtonPressed;
  const UserMealInvitation({super.key, this.onBackButtonPressed});

  bool isExpired(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    return date.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: BlocProvider(
        create: (context) => GetInvitationsCubit()..getInvitations(),
        child: BlocBuilder<GetInvitationsCubit, GetInvitationsState>(
          builder: (context, state) {
            if (state.status == GetInvitationStatus.loading) {
              return Center(child: AppLoading());
            } else if (state.status == GetInvitationStatus.success) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<GetInvitationsCubit>().getInvitations();
                },
                child: state.plans!.isEmpty
                    ? ListView(
                        padding: const EdgeInsets.all(20.0),
                        children: const [
                          SizedBox(height: 250),
                          Center(
                            child: FancyText(),
                          ),
                        ],
                      )
                    : ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 26),
                            width: maxWidth(context),
                            child: const Texts(
                              texts: 'Meal Plan Invitations',
                              color: AppColor.kTitleColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.plans?.length,
                            itemBuilder: (context, index) {
                              final _plan = state.plans!;
                              bool expired = isExpired(_plan[index].expiresAt!);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: UserPlansContainer(
                                  color: expired == true
                                      ? Colors.grey.shade300
                                      : Colors.white,
                                  onTap: () {
                                    expired == true
                                        ? ToasterService.error(
                                            message:
                                                'Invitation already expired')
                                        : PersistentNavBarNavigator
                                            .pushNewScreen(
                                            context,
                                            screen: MealPlanDetailsPage(
                                              id: _plan[index].mealPlan!.id!,
                                            ),
                                            withNavBar: true,
                                          );
                                  },
                                  url: _plan[index].instructorPicture ?? '',
                                  created: _plan[index].createdAt.toString(),
                                  numberOfDays: _plan[index]
                                      .mealPlan!
                                      .numberOfDays
                                      .toString(),
                                  planName: _plan[index]
                                      .mealPlan!
                                      .planName
                                      .toString(),
                                  price:
                                      _plan[index].mealPlan!.price.toString(),
                                  time: _plan[index].mealTimes.toString(),
                                  firstWord: _plan[index]
                                      .mealPlan!
                                      .planName
                                      .toString(),
                                  remainingDays:
                                      _plan[index].expiresAt.toString(),
                                  instructor: _plan[index].instructorName ??
                                      'Instructor',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              );
            } else if (state.status == GetInvitationStatus.error) {
              return const Center(
                child: ErrorTexts(
                  texts: 'No internet connection',
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
