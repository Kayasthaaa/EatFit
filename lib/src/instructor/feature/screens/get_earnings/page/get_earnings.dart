import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_state.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEarningsPage extends StatelessWidget {
  final void Function()? onTap;
  const GetEarningsPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetEarningsCubit, GetEarningsState>(
      builder: (context, state) {
        if (state.status == GetEarningsStatus.success) {
          final data = state.earnings;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Containers(
                  width: maxWidth(context),
                  child: const Texts(
                    texts: 'My Earnings',
                    color: AppColor.kTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 10),
                Containers(
                  onTap: onTap,
                  width: maxWidth(context),
                  height: 105,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Containers(
                            height: 105,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Texts(
                                  texts: 'Current Earning',
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 8),
                                const Texts(
                                  texts: 'NRS',
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: 6,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 4),
                                Texts(
                                  texts: '${data!.currentEarning} /-',
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Containers(
                            height: 105,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Texts(
                                  texts: 'LifeTime Earning',
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 8),
                                const Texts(
                                  texts: 'NRS',
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: 6,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 4),
                                Texts(
                                  texts: '${data.lifetimeEarning} /-',
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
