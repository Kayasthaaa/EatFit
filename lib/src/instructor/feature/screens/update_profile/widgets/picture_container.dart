import 'package:flutter/material.dart';

class PictureContainer extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  const PictureContainer(
      {super.key, this.child, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        // color: const Color.fromARGB(255, 59, 124, 118),
        border: Border.all(
            color: const Color.fromARGB(255, 59, 124, 118), width: 2),
      ),
      child: ClipOval(child: child),
    );
  }
}
