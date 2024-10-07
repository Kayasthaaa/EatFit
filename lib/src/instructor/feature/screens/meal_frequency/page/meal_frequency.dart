// ignore_for_file: library_private_types_in_public_api

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_meal_details/page/add_meal_details.dart';
import 'package:eat_fit/src/instructor/feature/screens/meal_frequency/widgets/meal_title_bar.dart';
import 'package:eat_fit/src/instructor/feature/screens/meal_frequency/widgets/state_field.dart';
import 'package:eat_fit/src/instructor/feature/screens/meal_frequency/widgets/time_field.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/mealBtn.dart';
import 'package:eat_fit/src/instructor/feature/widgets/smallHeading.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MealFrequencyPage extends StatefulWidget {
  final String mealName;
  final int mealNumber;

  const MealFrequencyPage(
      {super.key, required this.mealName, required this.mealNumber});
  @override
  _MealFrequencyPageState createState() => _MealFrequencyPageState();
}

class _MealFrequencyPageState extends State<MealFrequencyPage> {
  final form = GlobalKey<FormState>();
  List<TextEditingController> timeControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<TextEditingController> ampmControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void _addTextField() {
    if (timeControllers.length < 7) {
      setState(() {
        timeControllers.add(TextEditingController());
        ampmControllers.add(TextEditingController());
      });
    } else {
      ToasterService.error(message: "Maximum Order Should be less than 8");
    }
  }

  Future<void> _selectTime(int index) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        // Format selected time to 12-hour format with AM/PM
        final hour =
            selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod;
        final minute = selectedTime.minute.toString().padLeft(2, '0');
        final period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

        timeControllers[index].text = '$hour:$minute';
        ampmControllers[index].text = period;
      });
    }
  }

  void _removeTextField(int index) {
    if (timeControllers.length > 1) {
      setState(() {
        timeControllers.removeAt(index);
        ampmControllers.removeAt(index);
      });
    } else {
      ToasterService.error(message: "Minimun Order Should 1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kAppSpacing),
        child: Form(
          key: form,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              MealTitleBar(
                  backTap: () {
                    Navigator.pop(context);
                  },
                  addTap: _addTextField),
              const SizedBox(
                height: 10,
              ),
              Containers(
                margin: const EdgeInsets.only(left: 10, right: 19),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: timeControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const smallHeading(title: 'Meal Time'),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Containers(
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: TimeContainer(
                                          validator: time,
                                          controller: timeControllers[index],
                                          onPressed: () => _selectTime(index),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: StateField(
                                        controller: ampmControllers[index],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 1,
                                    child: Containers(
                                      onTap: () {
                                        _removeTextField(index);
                                      },
                                      height: 27,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            88, 195, 202, 1),
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset('images/cross.png'),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: MealBtn(
                        title: 'Add Meal Details',
                        onTap: () {
                          final isValid = form.currentState?.validate();
                          if (!isValid!) {
                            ToasterService.error(
                                message: 'Please enter all the times');
                            return;
                          } else {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: AddMealDetailsPage(
                                mealTimes: timeControllers.length,
                                mealname: widget.mealName,
                                times: timeControllers,
                                mealNumber: widget.mealNumber,
                                state: ampmControllers,
                              ),
                              withNavBar: true,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
