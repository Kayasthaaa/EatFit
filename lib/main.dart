import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_cubit.dart';
import 'src/instructor/constant/navigationService.dart';
import 'src/instructor/controller/network_controller.dart';
import 'src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_cubit.dart';
import 'src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_cubit.dart';
import 'src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'src/instructor/feature/screens/invite_code/cubit/auth_cubit.dart';
import 'src/instructor/feature/screens/login/cubit/login_cubit.dart';
import 'src/instructor/feature/screens/generate_code/cubit/generate_code_cubit.dart';
import 'src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'src/instructor/feature/screens/register/cubit/register_cubit.dart';
import 'src/instructor/feature/widgets/app_loading.dart';
import 'src/instructor/routes/routes.dart';
import 'src/user/feature/screen/user_meal_invitation/cubit/user_invitations_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // FCMService fcmService = FCMService();
  // await fcmService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBase();
  }
}

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit()..getNotifications(),
        ),
        BlocProvider(
          create: (context) => GetPayoutCubit()..getPayouts(),
        ),
        BlocProvider(
          create: (context) => GetEarningDetailsCubit()..getEarningDetails(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => GenerateCodeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => GetPlansCubit()..getPlans(),
        ),
        BlocProvider(
          create: (context) => GetSubscribersCubit()..getSubscribers(),
        ),
        BlocProvider(
          create: (context) => GetInvitationsCubit(),
        ),
        BlocProvider(
          create: (context) => GetEarningsCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
        navigatorKey: NavigationService.navigatorKey,
        builder: (context, navigator) {
          return ConnectivityWrapper(
            //? Return a default widget if navigator is null
            child: Center(child: navigator ?? AppLoading()),
          );
        },
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
