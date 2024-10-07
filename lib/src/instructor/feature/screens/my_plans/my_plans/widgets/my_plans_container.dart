import 'package:auto_size_text/auto_size_text.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/date.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansContainer extends StatelessWidget {
  final String created;
  final String planName;
  final String numberOfDays;
  final String time;
  final String totalSub;
  final String price;
  final String user;

  final String firstWord;
  const PlansContainer({
    super.key,
    required this.created,
    required this.planName,
    required this.numberOfDays,
    required this.time,
    required this.price,
    required this.user,
    required this.firstWord,
    required this.totalSub,
  });

  @override
  Widget build(BuildContext context) {
    return Containers(
      height: 120,
      width: maxWidth(context),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 12, left: 16),
            child: Containers(
              width: maxWidth(context),
              child: Align(
                alignment: Alignment.topRight,
                child: DateTextWidget(
                  dateString: created,
                ),
              ),
            ),
          ),
          Expanded(
            child: Containers(
              margin: const EdgeInsets.only(left: 15, bottom: 10),
              width: maxWidth(context),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Containers(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 2),
                            child: Containers(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(88, 195, 202, 1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Texts(
                                  texts: firstWord.capitalize!.substring(0, 1),
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 9.0),
                              child: Containers(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Texts(
                                      texts: planName,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(height: 3),
                                    Containers(
                                      width: maxWidth(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Texts(
                                            overflow: TextOverflow.ellipsis,
                                            texts: '$numberOfDays Days',
                                            fontSize: 10,
                                            color: const Color.fromRGBO(
                                                183, 183, 183, 1),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          Texts(
                                            texts: '$time Times a Day',
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 7,
                                            color: const Color.fromRGBO(
                                                183, 183, 183, 1),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 12),
                      child: Containers(
                        height: 55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 6),
                            Texts(
                              texts: price,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(234, 93, 36, 1),
                            ),
                            const SizedBox(height: 4),
                            Containers(
                              width: 90,
                              height: 19,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromRGBO(101, 199, 55, 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '$user/',
                                    minFontSize: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 5,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  AutoSizeText(
                                    '$totalSub Subscribers',
                                    minFontSize: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 5,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
