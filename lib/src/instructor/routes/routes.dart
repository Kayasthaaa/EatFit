import 'package:eat_fit/src/instructor/bottom_navigation.dart';
import 'package:eat_fit/src/instructor/feature/screens/add_plan/page/add_plan.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/page/get_earnings.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/page/login_page.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/page/my_plans.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/page/profile.dart';
import 'package:eat_fit/src/instructor/feature/screens/splash/page/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreenPage(),
        );

      case '/user-login-screen':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/user-bottomNav-screen':
        return MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        );
      case '/user-addPlan-screen':
        return MaterialPageRoute(
          builder: (context) => const AddPlanPage(),
        );
      case '/user-profile-screen':
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      case '/user-myPlans-screen':
        return MaterialPageRoute(
          builder: (context) => const MyPlansPage(),
        );
      case '/user-Earning-details':
        return MaterialPageRoute(
          builder: (context) => const GetEarningsPage(),
        );

      default:
        return null;
    }
  }
}
