// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Widget SplashContainer() {
  return Container(
    child: Column(
      children: [
        Image.asset('images/eatfitlogo.png'),
        const SizedBox(
          height: 10,
        ),
        const Text('Today')
      ],
    ),
  );
}
