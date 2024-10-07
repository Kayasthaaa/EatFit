// ignore_for_file: non_constant_identifier_names, file_names

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

Widget LogoutBtn(BuildContext context, void Function()? onTap) {
  return Containers(
    onTap: onTap,
    margin: const EdgeInsets.symmetric(horizontal: 22),
    height: 45,
    width: maxWidth(context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.red,
    ),
    child: const Center(
      child: Texts(
        texts: 'Logout',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
