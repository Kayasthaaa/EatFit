import 'package:flutter/material.dart';

class CustomTabBarIndicator extends Decoration {
  final String selectedTabText;

  const CustomTabBarIndicator({required this.selectedTabText});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabBarIndicatorPainter(selectedTabText: selectedTabText);
  }
}

class _CustomTabBarIndicatorPainter extends BoxPainter {
  final String selectedTabText;

  _CustomTabBarIndicatorPainter({required this.selectedTabText});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final Rect rect = offset & configuration.size!;
    final RRect rrect = selectedTabText == 'Earnings'
        ? RRect.fromRectAndCorners(
            rect,
            topLeft: const Radius.circular(25.0),
            bottomLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(0.0),
            bottomRight: const Radius.circular(0.0),
          )
        : RRect.fromRectAndCorners(
            rect,
            topLeft: const Radius.circular(0.0),
            bottomLeft: const Radius.circular(0.0),
            topRight: const Radius.circular(25.0),
            bottomRight: const Radius.circular(25.0),
          );

    canvas.drawRRect(rrect, paint);
  }
}
