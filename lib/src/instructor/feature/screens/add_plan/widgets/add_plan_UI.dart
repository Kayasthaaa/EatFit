// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/kTitlleText.dart';
import 'package:eat_fit/src/instructor/feature/widgets/mealBtn.dart';
import 'package:eat_fit/src/instructor/feature/widgets/smallHeading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/meal_frequency/page/meal_frequency.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AddPlanForm extends StatefulWidget {
  const AddPlanForm({super.key});

  @override
  _AddPlanFormState createState() => _AddPlanFormState();
}

class _AddPlanFormState extends State<AddPlanForm> {
  final form = GlobalKey<FormState>();
  late final TextEditingController mealNameController;
  late final TextEditingController mealTimesController;

  @override
  void initState() {
    super.initState();
    mealNameController = TextEditingController();
    mealTimesController = TextEditingController();
  }

  @override
  void dispose() {
    mealNameController.dispose();
    mealTimesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildTitleContainer(),
          const SizedBox(height: 10),
          _buildMealPlanContainer(),
        ],
      ),
    );
  }

  Widget _buildTitleContainer() {
    return Containers(
      width: maxWidth(context),
      height: 14,
      child: const kTtile(title: 'Create New Meal Plan'),
    );
  }

  Widget _buildMealPlanContainer() {
    return Containers(
      height: 260,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const smallHeading(title: 'Meal Plan Name'),
            const SizedBox(height: 5),
            _buildMealField(
              mealNameController,
              validateNames,
            ),
            const SizedBox(height: 15),
            const smallHeading(title: 'No of Days'),
            const SizedBox(height: 5),
            _buildMealField(mealTimesController, validateInteger),
            const SizedBox(height: 18),
            MealBtn(
              title: 'Add Meal Times',
              onTap: () async {
                final isValid = form.currentState?.validate();
                if (isValid == false) {
                  ToasterService.error(message: 'Please enter valid data');
                  return;
                } else {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MealFrequencyPage(
                      mealName: mealNameController.text.toString(),
                      mealNumber: int.parse(mealTimesController.text),
                    ),
                    withNavBar: true,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealField(
      TextEditingController controller, String? Function(String?) validator) {
    return MealField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      mealController: controller,
    );
  }
}
