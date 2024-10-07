import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

class PlanDetailsContainer extends StatelessWidget {
  final String created;
  final String planName;
  final String numberOfDays;
  final String time;
  final String price;
  final String user;
  final String firstWord;
  final String totalSub;
  const PlanDetailsContainer(
      {super.key,
      required this.created,
      required this.planName,
      required this.numberOfDays,
      required this.time,
      required this.price,
      required this.user,
      required this.firstWord,
      required this.totalSub});

  @override
  Widget build(BuildContext context) {
    return Containers(
      width: maxWidth(context),
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          Containers(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(88, 195, 202, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Texts(
                texts: planName.substring(0, 1),
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Containers(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(
                    texts: planName.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 4),
                  Texts(
                    texts: 'NRS $price/-',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(234, 93, 36, 1),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Containers(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Containers(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts(
                                    texts: '$numberOfDays Days',
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 9,
                                    color:
                                        const Color.fromRGBO(183, 183, 183, 1),
                                  ),
                                  Texts(
                                    texts: '$time Times a Day',
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 8,
                                    color:
                                        const Color.fromRGBO(183, 183, 183, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Containers(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.5, vertical: 9.5),
                                      child: Containers(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              101, 199, 55, 1),
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                        ),
                                        child: Center(
                                          child: Texts(
                                            texts: user,
                                            fontSize: 6,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 4,
                                    child: Containers(
                                      child: Texts(
                                        texts: 'Active \nSubscribers',
                                        fontSize: 8,
                                        color: Color.fromRGBO(158, 158, 158, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Containers(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.5, vertical: 9.5),
                                      child: Containers(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              167, 170, 166, 1),
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                        ),
                                        child: Center(
                                          child: Texts(
                                            texts: totalSub,
                                            fontSize: 6,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 4,
                                    child: Containers(
                                      child: Texts(
                                        texts: 'Total \nSubscribers',
                                        fontSize: 8,
                                        color: Color.fromRGBO(158, 158, 158, 1),
                                      ),
                                    ),
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
            ),
          )
        ],
      ),
    );
  }
}
