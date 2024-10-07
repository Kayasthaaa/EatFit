// ignore_for_file: camel_case_types, file_names

import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:flutter/material.dart';

class smallHeading extends StatelessWidget {
  final String title;
  const smallHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Texts(
      texts: title,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: AppColor.kSmallHeadning,
    );
  }
}
