import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget btnText(String label) {
  return Text(
    label,
    style: GoogleFonts.inter(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
  );
}
