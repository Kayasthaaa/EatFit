import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ReadMore extends StatelessWidget {
  final String texts;
  const ReadMore({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      texts,
      trimLines: 2,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: '...read more',
      trimExpandedText: ' show less',
      textAlign: TextAlign.justify,
      style: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: const Color.fromRGBO(104, 104, 104, 1),
      ),
    );
  }
}
