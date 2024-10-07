import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorTexts extends StatelessWidget {
  final String texts;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? height;

  final void Function()? onTap;
  final TextDecoration? decoration;
  const ErrorTexts(
      {super.key,
      required this.texts,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.overflow,
      this.textAlign,
      this.maxLines,
      this.fontStyle,
      this.height,
      this.onTap,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        texts,
        overflow: overflow,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: GoogleFonts.alike(
          fontSize: 28,
          fontWeight: fontWeight,
          color: Colors.black,
          decoration: decoration,
          fontStyle: fontStyle,
          textStyle: TextStyle(height: height),
        ),
      ),
    );
  }
}
