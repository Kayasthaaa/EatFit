import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/date.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/widgets/picture_container.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMealContainer extends StatelessWidget {
  final String created;
  final String planName;
  final String numberOfDays;
  final String time;
  final String instructor;
  final String firstWord;
  final String url;
  final double? value;
  final Widget? child;
  final void Function()? onTap;
  final EdgeInsetsGeometry margin;
  const UserMealContainer({
    super.key,
    required this.created,
    required this.planName,
    required this.numberOfDays,
    required this.firstWord,
    required this.url,
    required this.instructor,
    required this.time,
    this.onTap,
    this.value,
    this.child,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Containers(
      onTap: onTap,
      margin: margin,
      height: 128,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 12, bottom: 10),
        child: Column(
          children: [
            Containers(
              width: maxWidth(context),
              child: PaidMeals(
                dateString: created,
              ),
            ),
            Expanded(
              child: Containers(
                child: Row(
                  children: [
                    const SizedBox(width: 13),
                    Containers(
                      width: 80,
                      height: 80,
                      child: Containers(
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Containers(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Containers(
                                  child: Row(
                                    children: [
                                      PictureContainer(
                                        width: 16,
                                        height: 16,
                                        child: CachedNetworkImage(
                                          imageUrl: url,
                                          width: 16,
                                          height: 16,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) {
                                            return Image.asset(
                                              'images/eatfitbar.png',
                                              width: 16,
                                              height: 16,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Texts(
                                          texts: instructor,
                                          color: const Color.fromRGBO(
                                              183, 183, 183, 1),
                                          fontSize: 6,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Containers(
                                  child: Texts(
                                    texts: planName,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Containers(
                                  child: Texts(
                                    overflow: TextOverflow.ellipsis,
                                    texts: '$numberOfDays Days',
                                    fontSize: 10,
                                    color:
                                        const Color.fromRGBO(183, 183, 183, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Containers(
                                  child: Texts(
                                    texts: '$time Times a Day',
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 7,
                                    color:
                                        const Color.fromRGBO(183, 183, 183, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Containers(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: child,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
