import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/date.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({super.key});

  @override
  State<EarningsTabPage> createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
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
      body: BlocBuilder<GetEarningDetailsCubit, GetEarningsDetailsState>(
        builder: (context, state) {
          final data = state.plans;
          if (state.status == GetEarningsDetailsStatus.loading) {
            return Center(
              child: AppLoading(),
            );
          } else if (state.status == GetEarningsDetailsStatus.success) {
            return data!.isEmpty
                ? const Center(
                    child: Texts(
                      texts: 'No earnings yet ',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                  ),
                                  const Spacer(),
                                  if (data[index].status == 'Complete')
                                    Row(
                                      children: [
                                        Texts(
                                          texts: data[index].status.toString(),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                        ),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          height: 13,
                                          width: 13,
                                          child: Image.asset(
                                            'images/doc.png',
                                          ),
                                        )
                                      ],
                                    )
                                  else
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
                  );
          } else if (state.status == GetEarningsDetailsStatus.error) {
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
