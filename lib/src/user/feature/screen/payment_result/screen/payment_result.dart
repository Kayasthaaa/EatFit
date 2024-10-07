import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/user/feature/screen/subscribe_meal_plan/widget/sub_widget.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';

import 'package:flutter/material.dart';

class PaymentResultPage extends StatelessWidget {
  final UserMealDetailsModels models;
  final UserInvitationsModels inv;
  const PaymentResultPage({super.key, required this.models, required this.inv});

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
                created: models.modifiedAt!,
                planName: models.planName!,
                numberOfDays: models.numberOfDays.toString(),
                price: models.price!,
                firstWord: models.planName!,
                remainingDays: inv.expiresAt.toString(),
                url: models.instructorPicture ?? '',
                instructor: models.instructorName ?? 'Instructor',
                time: models.mealTimes!.length.toString(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: const Row(
                children: [
                  Texts(
                    overflow: TextOverflow.ellipsis,
                    texts: 'Delivery Details > Payment Details > ',
                    color: Color.fromRGBO(184, 185, 185, 1),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  Flexible(
                    child: Texts(
                      texts: 'Delivery Details',
                      color: AppColor.kTitleColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 190,
              width: maxWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(16.0),
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
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              child: const Column(
                children: [
                  Texts(
                    texts: 'Your Order has been confirmed!',
                    color: Color.fromRGBO(27, 201, 76, 1),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 16.0),
                  Texts(
                    texts: 'Order Id',
                    fontSize: 9,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 3),
                  Texts(
                    texts: '#EFT122212',
                    fontSize: 19,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 13.0),
                  Texts(
                    texts:
                        'You will receive a confirmation call from our team!',
                    fontSize: 9,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 16.0),
                  Texts(
                    texts: 'Thankyou for using EFT',
                    fontSize: 9,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22.0),
            Container(
              height: 190,
              width: maxWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(16.0),
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
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              child: const Column(
                children: [
                  Texts(
                    texts: 'Order Confirmation Failed!',
                    color: Color.fromRGBO(249, 35, 35, 1),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 16.0),
                  Texts(
                    texts: 'Please',
                    fontSize: 9,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 6),
                  Texts(
                    texts: 'TRY AGAIN',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    underlineColor: AppColor.kTitleColor,
                    color: AppColor.kTitleColor,
                  ),
                  SizedBox(height: 16.0),
                  Texts(
                    texts:
                        'or reach out to your special service representative at',
                    fontSize: 9,
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5),
                  Texts(
                    texts: '+977 9801 224242',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    underlineColor: Color.fromRGBO(69, 194, 240, 1),
                    color: Color.fromRGBO(69, 194, 240, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
