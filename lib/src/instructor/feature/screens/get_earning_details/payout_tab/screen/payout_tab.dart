import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/widgets/dialog_widgets.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/cubit/post_payouts_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/cubit/post_payouts_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/generate_link_container.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/date.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/mealBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayoutPage extends StatefulWidget {
  const PayoutPage({super.key});

  @override
  State<PayoutPage> createState() => _PayoutPageState();
}

class _PayoutPageState extends State<PayoutPage> {
  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  bool validateAmount(String input) {
    return RegExp(r'^[0-9]+$').hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetPayoutCubit, GetPayoutsState>(
        builder: (context, state) {
          final data = state.plans;
          if (state.status == GetPayoutsStatus.loading) {
            return Center(
              child: AppLoading(),
            );
          } else if (state.status == GetPayoutsStatus.success) {
            return Column(
              children: [
                BlocProvider(
                  create: (context) => PostPayoutCubit(),
                  child: BlocConsumer<PostPayoutCubit, PostPayoutState>(
                    listener: (context, state) {
                      if (state.status == PostPayoutStatus.success) {
                        Navigator.pop(context);
                        ToasterService.success(
                            message: 'Payout has been requested');
                        amountController.clear();
                      } else if (state.errorMessage != null) {
                        ToasterService.error(message: state.errorMessage!);
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: 130,
                        height: 45,
                        child: MealBtn(
                          title: 'Request Payout',
                          onTap: () {
                            showPayoutDialog(
                              context,
                              GestureDetector(
                                onTap: () async {
                                  var connectivityResult =
                                      await Connectivity().checkConnectivity();
                                  if (connectivityResult ==
                                      ConnectivityResult.none) {
                                    ToasterService.error(
                                        message: 'No internet connection');
                                  } else {
                                    if (!validateAmount(
                                        amountController.text)) {
                                      ToasterService.error(
                                          message: 'Please add valid number');
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                        (_) {
                                          context
                                              .read<PostPayoutCubit>()
                                              .postPayout(
                                                  amountController.text);
                                        },
                                      );
                                    }
                                  }
                                },
                                child: GenerateLinkContainer(
                                  child: Center(
                                    child:
                                        state.status == PostPayoutStatus.loading
                                            ? loading()
                                            : const FittedBox(
                                                child: Texts(
                                                  texts: 'Request',
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                              amountController,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                data!.isEmpty
                    ? const Center(
                        child: Texts(
                          texts: 'No payouts yet ',
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 28),
                            width: maxWidth(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Containers(
                                  width: maxWidth(context),
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EarningsDate(
                                        dateString:
                                            data[index].modifiedAt.toString(),
                                      ),
                                      const Spacer(),
                                      Texts(
                                        texts: 'NRs ${data[index].amount}/-',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                      ),
                                      const Spacer(),
                                      Texts(
                                        texts: data[index].status.toString(),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Image.asset(
                                  'images/lines.png',
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            );
          } else if (state.status == GetPayoutsStatus.error) {
            return const Center(
              child: ErrorTexts(texts: 'No internet connection'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
