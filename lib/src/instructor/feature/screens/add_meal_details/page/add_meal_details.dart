// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/bottom_navigation.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/cubit/add_meal_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/cubit/add_meal_details_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/generate_link_container.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class AddMealDetailsPage extends StatefulWidget {
  final int mealTimes;
  final int mealNumber;
  final String mealname;
  final List<TextEditingController> times;
  final List<TextEditingController> state;

  const AddMealDetailsPage({
    super.key,
    required this.mealTimes,
    required this.times,
    required this.mealNumber,
    required this.state,
    required this.mealname,
  });

  @override
  _AddMealDetailsPageState createState() => _AddMealDetailsPageState();
}

class _AddMealDetailsPageState extends State<AddMealDetailsPage> {
  late List<List<TextEditingController>> mealControllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    mealControllers = List.generate(
      widget.mealNumber,
      (_) => List.generate(
        widget.mealTimes,
        (_) => TextEditingController(),
      ),
    );
  }

  List<MapEntry<String, String>> sortTimes() {
    List<MapEntry<String, String>> timeEntries = [];
    for (int i = 0; i < widget.times.length; i++) {
      timeEntries.add(MapEntry(widget.times[i].text, widget.state[i].text));
    }
    timeEntries.sort((a, b) {
      final aTime = _parseTime(a.key, a.value);
      final bTime = _parseTime(b.key, b.value);
      return aTime.compareTo(bTime);
    });
    return timeEntries;
  }

  DateTime _parseTime(String time, String amPm) {
    final parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    if (amPm.toUpperCase() == 'PM' && hour != 12) hour += 12;
    if (amPm.toUpperCase() == 'AM' && hour == 12) hour = 0;
    return DateTime(2024, 1, 1, hour, minute);
  }

  @override
  void dispose() {
    for (var dayControllers in mealControllers) {
      for (var controller in dayControllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Map<String, dynamic> _sendMealPlanToServer() {
    final String planName = widget.mealname.trim();
    if (planName.isEmpty) {
      return {};
    }

    final List<Map<String, dynamic>> mealsList = List.generate(
      widget.mealNumber,
      (dayIndex) {
        final List<Map<String, dynamic>> dayMealsList =
            List.generate(widget.mealTimes, (mealIndex) {
          final TextEditingController controller =
              mealControllers[dayIndex][mealIndex];
          return {
            'time': widget.times[mealIndex].text,
            'description': controller.text,
          };
        });

        return {
          'day': dayIndex + 1,
          'day_meals': dayMealsList,
        };
      },
    );

    final List<Map<String, dynamic>> mealTimesList = widget.times
        .where((controller) => controller.text.isNotEmpty)
        .map((controller) => {'time': controller.text})
        .toList();

    if (mealTimesList.isEmpty) {
      return {};
    }

    return {
      'plan_name': widget.mealname,
      'number_of_days': widget.mealNumber,
      'price': '0',
      'meal_times': mealTimesList,
      'meals': mealsList,
    };
  }

  @override
  Widget build(BuildContext context) {
    final sortedTimes = sortTimes();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.mealNumber,
                itemBuilder: (_, int dayIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts(
                                  texts: 'DAY ${dayIndex + 1}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(234, 93, 36, 1),
                                ),
                                if (dayIndex > 0)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < widget.mealTimes;
                                            i++) {
                                          mealControllers[dayIndex][i].text =
                                              mealControllers[dayIndex - 1][i]
                                                  .text;
                                        }
                                      });
                                    },
                                    child: const Texts(
                                      texts: 'DUPLICATE ABOVE',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      color: Color.fromRGBO(176, 176, 176, 1),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              itemCount: sortedTimes.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (_, int timeIndex) {
                                final time = sortedTimes[timeIndex].key;
                                final amPm = sortedTimes[timeIndex].value;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Texts(
                                          texts: time,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              197, 196, 196, 1),
                                        ),
                                        const SizedBox(width: 5),
                                        Texts(
                                          texts: amPm,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              197, 196, 196, 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    MealField(
                                      validator: validateNames,
                                      mealController: mealControllers[dayIndex]
                                          [timeIndex],
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocProvider(
                create: (context) => AddMealPlanCubit(),
                child: BlocConsumer<AddMealPlanCubit, AddMealPlanState>(
                  listener: (context, state) {
                    if (state.status == AddMealPlanStatus.success) {
                      Get.off(() => const BottomNavigation(initialIndex: 1));
                      ToasterService.success(
                          message: 'Meal plan added successfully');
                      mealControllers.clear();
                    } else if (state.status == AddMealPlanStatus.error) {
                      ToasterService.error(
                          message:
                              'You already have three unverified meal plans. Cannot create a new one');
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state.status == AddMealPlanStatus.loading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  ToasterService.error(
                                      message: 'No internet connection');
                                  return;
                                }
                                context
                                    .read<AddMealPlanCubit>()
                                    .addMealPlan(_sendMealPlanToServer());
                              } else {
                                ToasterService.error(
                                    message: 'Please enter valid details');
                              }
                            },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GenerateLinkContainer(
                          child: state.status == AddMealPlanStatus.loading
                              ? loading()
                              : const Texts(
                                  texts: 'Submit for Review',
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
