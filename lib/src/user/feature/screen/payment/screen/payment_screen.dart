// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/user/feature/screen/payment_result/screen/payment_result.dart';
import 'package:eat_fit/src/user/feature/screen/subscribe_meal_plan/widget/sub_widget.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PaymentScreen extends StatefulWidget {
  final UserMealDetailsModels models;
  final UserInvitationsModels inv;
  const PaymentScreen({super.key, required this.models, required this.inv});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = '';

  void selectPaymentMethod(String method) {
    setState(() {
      if (selectedPaymentMethod == method) {
        selectedPaymentMethod = '';
      } else {
        selectedPaymentMethod = method;
      }
    });
  }

  int calculateExpiryDays(String modifiedAt, int numberOfDays) {
    DateTime modifiedDate = DateTime.parse(modifiedAt);
    DateTime expiryDate = modifiedDate.add(Duration(days: numberOfDays));
    Duration difference = expiryDate.difference(DateTime.now());
    return difference.inDays;
  }

  Widget buildPaymentContainer(String method, String assetPath) {
    return GestureDetector(
      onTap: () {
        selectPaymentMethod(method);
      },
      child: Container(
        width: maxWidth(context) / 2.5,
        height: 95,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
          border: Border.all(
            color: selectedPaymentMethod == method
                ? Colors.green
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 110,
            height: 100,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: maxWidth(context),
              child: const Texts(
                texts: 'Subscribe Meal Plan',
                color: AppColor.kTitleColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SubContainer(
                created: widget.models.modifiedAt!,
                planName: widget.models.planName!,
                numberOfDays: widget.models.numberOfDays.toString(),
                price: widget.models.price!,
                firstWord: widget.models.planName!,
                remainingDays: widget.inv.expiresAt.toString(),
                url: widget.models.instructorPicture ?? '',
                instructor: widget.models.instructorName ?? 'Instructor',
                time: widget.models.mealTimes!.length.toString(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: const Row(
                children: [
                  Texts(
                    texts: 'Delivery Details > ',
                    color: Color.fromRGBO(184, 185, 185, 1),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  Texts(
                    texts: 'Delivery Details',
                    color: AppColor.kTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: const Texts(
                texts: 'Select Payment Method',
                color: Color.fromRGBO(104, 104, 104, 1),
                fontSize: 9,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildPaymentContainer('fonepay', 'images/fonepay.png'),
                    buildPaymentContainer('imepay', 'images/ime.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildPaymentContainer('esewa', 'images/esewa.png'),
                    buildPaymentContainer('khalti', 'images/khalti.png'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 110),
            Containers(
              onTap: () {
                if (selectedPaymentMethod.isEmpty) {
                  ToasterService.error(message: 'Please select payment option');
                } else {
                  if (selectedPaymentMethod != 'fonepay') {
                    ToasterService.error(message: 'Comming soon');
                  } else {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PaymentResultPage(
                        models: widget.models,
                        inv: widget.inv,
                      ),
                      withNavBar: true,
                    );
                  }
                }
              },
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: maxWidth(context),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(49, 191, 89, 1),
              ),
              child: const Center(
                child: Texts(
                  color: Colors.white,
                  texts: 'Make Payment',
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
