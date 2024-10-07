// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/page/my_plan_details.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/my_plans_container.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/fancy_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyProfilePlansUI extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const MyProfilePlansUI({super.key, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlansCubit, GetPlansState>(
      builder: (context, state) {
        if (state.status == GetPlansStatus.success) {
          return state.plans!.isEmpty
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
                      const SizedBox(height: 20),
                      Container(
                        margin: margin,
                        width: maxWidth(context),
                        child: const Texts(
                          texts: 'My Plans',
                          color: AppColor.kTitleColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<GetSubscribersCubit, GetSubscribersState>(
                        builder: (context, substate) {
                          if (substate.status == GetSubscribersStatus.success) {
                            final sub = substate.subscribers!;
                            final uniquePlans = <String, dynamic>{};

                            for (var subscriber in sub) {
                              uniquePlans[subscriber.mealPlan!.planName!] =
                                  subscriber;
                            }

                            final uniqueSubscribers =
                                uniquePlans.values.toList();

                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.plans?.length,
                              itemBuilder: (context, index) {
                                final _plan = state.plans![index];
                                final correspondingSub =
                                    uniqueSubscribers.firstWhere(
                                        (sub) =>
                                            sub.mealPlan!.planName ==
                                            _plan.planName,
                                        orElse: () => null);

                                return Padding(
                                  padding: padding!,
                                  child: GestureDetector(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: MyPlanDetailsPage(
                                          total: correspondingSub != null
                                              ? (correspondingSub
                                                          .activeSubscribers! +
                                                      correspondingSub
                                                          .inactiveSubscribers!)
                                                  .toString()
                                              : '0',
                                          active: correspondingSub != null
                                              ? correspondingSub
                                                  .activeSubscribers
                                                  .toString()
                                              : '0',
                                          id: _plan.id!,
                                          mealDays: _plan.mealTimes!.length,
                                        ),
                                        withNavBar: true,
                                      );
                                    },
                                    child: PlansContainer(
                                      created: _plan.modifiedAt.toString(),
                                      planName: _plan.planName.toString(),
                                      numberOfDays:
                                          _plan.numberOfDays.toString(),
                                      time: _plan.mealTimes!.length.toString(),
                                      price: _plan.verified.toString() ==
                                                  'Pending' ||
                                              _plan.verified.toString() == '0'
                                          ? 'Pending'
                                          : "NRs ${_plan.price}/- ",
                                      user: correspondingSub != null
                                          ? correspondingSub.activeSubscribers
                                              .toString()
                                          : '0',
                                      firstWord: _plan.planName.toString(),
                                      totalSub: correspondingSub != null
                                          ? (correspondingSub
                                                      .activeSubscribers! +
                                                  correspondingSub
                                                      .inactiveSubscribers!)
                                              .toString()
                                          : '0',
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
