// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:eat_fit/src/instructor/bottom_navigation.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/page/login_page.dart';
import 'package:eat_fit/src/instructor/feature/widgets/appLogo.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/user/user_bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  late bool _isAuthenticated;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isAuthenticated = false;
    _showLogoForThreeSeconds();
  }

  void _showLogoForThreeSeconds() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _checkAuthentication();
      }
    });
  }

  void _checkAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    setState(() {
      _isAuthenticated = isAuthenticated;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: _isLoading
          ? _buildSplashScreen()
          : _isAuthenticated
              ? _navigateToBottomNavigation()
              : const LoginPage(),
    );
  }

  Widget _buildSplashScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kAppSpacing),
      child: Stack(
        children: [
          Center(
            child: appLogo(BoxFit.fill),
          ),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 210.0),
              child: Texts(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                texts: 'Great Food Everyday!',
                color: AppColor.ktextColor,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.0),
              child: Texts(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                texts: 'INVITE ONLY COMMUNITY',
                color: AppColor.ktextColor,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Texts(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                texts: 'v 0.0.1',
                color: AppColor.ktextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigateToBottomNavigation() {
    return FutureBuilder<String?>(
      future: _getUserType(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userType = snapshot.data;
          if (userType == 'Instructor') {
            return const BottomNavigation();
          } else if (userType == 'Normal') {
            return const UserBottomNavigation();
          } else if (userType == 'Admin') {
            return const UserBottomNavigation();
          } else {
            return const LoginPage();
          }
        } else {
          return Center(
            child: AppLoading(),
          );
        }
      },
    );
  }

  Future<String?> _getUserType() async {
    final SharedPreferences userType = await SharedPreferences.getInstance();
    return userType.getString('userType');
  }
}
