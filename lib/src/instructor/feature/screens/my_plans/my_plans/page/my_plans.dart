import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/get_plans.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlansPage extends StatelessWidget {
  const MyPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GetPlansCubit()..getPlans(),
          ),
          BlocProvider(
            create: (context) => GetSubscribersCubit()..getSubscribers(),
          ),
        ],
        child: const MyPlansUI(
          margin: EdgeInsets.symmetric(horizontal: 26),
          padding: EdgeInsets.only(left: 26, right: 26, bottom: 25),
        ),
      ),
    );
  }
}
