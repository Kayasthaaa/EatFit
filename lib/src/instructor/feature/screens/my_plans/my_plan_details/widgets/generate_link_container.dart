import 'package:flutter/material.dart';

class GenerateLinkContainer extends StatelessWidget {
  final Widget? child;
  const GenerateLinkContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 127,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromRGBO(88, 195, 202, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
