// ignore_for_file: file_names

import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

class MealBtn extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const MealBtn({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Containers(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(88, 195, 202, 1),
      ),
      onTap: onTap,
      width: 108,
      height: 43,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FittedBox(
            child: Texts(
              texts: title,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
    );
  }
}
