// ignore_for_file: non_constant_identifier_names

import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

Widget GridContainer(String texts, void Function()? onTap) {
  return Containers(
    onTap: onTap,
    width: 55,
    height: 61,
    // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: const Color.fromRGBO(214, 214, 214, 1),
      ),
    ),
    child: Center(
      child: Texts(
        texts: texts,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: const Color.fromRGBO(165, 165, 165, 1),
      ),
    ),
  );
}
