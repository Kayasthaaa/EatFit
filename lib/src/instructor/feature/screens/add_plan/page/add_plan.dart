import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_plan/widgets/add_plan_UI.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AddPlanPage extends StatelessWidget {
  const AddPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: kAppSpacing),
        child: AddPlanForm(),
      ),
    );
  }
}
