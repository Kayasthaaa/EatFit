// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/screen/earning_tab.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/screen/payout_tab.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/page/get_earnings.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEarningDetailsPage extends StatefulWidget {
  const GetEarningDetailsPage({super.key});

  @override
  _GetEarningDetailsPageState createState() => _GetEarningDetailsPageState();
}

class _GetEarningDetailsPageState extends State<GetEarningDetailsPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  bool _isPage1Selected = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
      _isPage1Selected = index == 0;
    });
  }

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
            create: (context) => GetPayoutCubit()..getPayouts(),
          ),
          BlocProvider(
            create: (context) => GetEarningsCubit()..getEarnings(),
          ),
          BlocProvider(
            create: (context) => GetEarningDetailsCubit()..getEarningDetails(),
          ),
        ],
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: GetEarningsPage(), // Replace with your actual widget
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Containers(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _isPage1Selected = true;
                    });
                  },
                  width: 140,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(201, 201, 201, 1),
                    ),
                    color: _isPage1Selected
                        ? const Color.fromRGBO(217, 217, 217, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                    ),
                  ),
                  child: const Center(
                    child: Texts(
                      texts: 'Earnings',
                      color: Color.fromRGBO(106, 106, 106, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Containers(
                  onTap: () {
                    _pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _isPage1Selected = false;
                    });
                  },
                  width: 140,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(201, 201, 201, 1),
                    ),
                    color: !_isPage1Selected
                        ? const Color.fromRGBO(217, 217, 217, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                  child: const Center(
                    child: Texts(
                      texts: 'Payouts',
                      color: Color.fromRGBO(106, 106, 106, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  BlocProvider(
                    create: (context) => GetEarningsCubit()..getEarnings(),
                    child: const EarningsTabPage(),
                  ),
                  BlocProvider(
                    create: (context) => GetPayoutCubit()..getPayouts(),
                    child: const PayoutPage(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
