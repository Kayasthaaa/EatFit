import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  const FancyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Texts(
        texts: 'No Plans Yet',
        color: Colors.black,
        fontSize: 28,
      ),
    );
  }
}
