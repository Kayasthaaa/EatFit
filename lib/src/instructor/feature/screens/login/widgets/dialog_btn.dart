// ignore_for_file: file_names

import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';

class DialogBtn extends StatelessWidget {
  final void Function()? onTap;

  final Widget? child;
  const DialogBtn({super.key, this.onTap, this.child});

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
        child: Center(child: child),
      ),
    );
  }
}
