import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  final Color? textColor;
  final Color? color;
  final Widget? child;

  final void Function()? onTap;
  const AppBtn({
    super.key,
    this.onTap,
    this.textColor,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: onTap,
      child: Container(
        height: 63.0,
        decoration: const BoxDecoration(
          color: AppColor.kbtnColor,
          // borderRadius: BorderRadius.circular(7.0),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
