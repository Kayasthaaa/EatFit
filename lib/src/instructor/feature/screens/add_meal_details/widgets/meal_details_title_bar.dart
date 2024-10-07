import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/widgets/kTitlleText.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

class MealDetailsBar extends StatelessWidget {
  final void Function()? backTap;
  const MealDetailsBar({super.key, this.backTap});

  @override
  Widget build(BuildContext context) {
    return Containers(
      margin: const EdgeInsets.only(left: 5, right: 20),
      width: maxWidth(context),
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Containers(
              child: Row(
                children: [
                  Containers(
                    onTap: backTap,
                    margin: const EdgeInsets.only(bottom: 2.5),
                    height: 30,
                    width: 30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 4),
                      child: Image.asset(
                        'images/back.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const kTtile(
                    title: 'Add Meal Details',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
