import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateTextWidget extends StatelessWidget {
  final String dateString;

  const DateTextWidget({
    super.key,
    required this.dateString,
  });

  String convertDateFormat(String originalDate) {
    // Parse the original date string into a DateTime object
    DateTime dateTime = DateTime.parse(originalDate);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd\'th\' MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Texts(
          texts: convertDateFormat(dateString),
          fontSize: 6,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(183, 183, 183, 1),
        ),
      ],
    );
  }
}

// this is for normal user

class DateTextWidgetUser extends StatelessWidget {
  final String dateString;
  final int remainingDays;

  const DateTextWidgetUser({
    super.key,
    required this.dateString,
    required this.remainingDays,
  });

  String convertDateFormat(String originalDate) {
    // Parse the original date string into a DateTime object
    DateTime dateTime = DateTime.parse(originalDate);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd\'th\' MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Texts(
          texts: convertDateFormat(dateString),
          fontSize: 6,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(183, 183, 183, 1),
        ),
        Texts(
          texts: 'Expires in $remainingDays days',
          fontSize: 6,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(183, 183, 183, 1),
        ),
      ],
    );
  }
}

// this is for earnings

class EarningsDate extends StatelessWidget {
  final String dateString;

  const EarningsDate({
    super.key,
    required this.dateString,
  });

  String convertDateFormat(String originalDate) {
    // Parse the original date string into a DateTime object
    DateTime dateTime = DateTime.parse(originalDate);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd\'th\' MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Texts(
      texts: convertDateFormat(dateString),
      fontSize: 6,
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(183, 183, 183, 1),
    );
  }
}

//?this is for nornal user's paid plan

// this is for normal user

class PaidMeals extends StatelessWidget {
  final String dateString;

  const PaidMeals({
    super.key,
    required this.dateString,
  });

  String convertDateFormat(String originalDate) {
    // Parse the original date string into a DateTime object
    DateTime dateTime = DateTime.parse(originalDate);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd\'th\' MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Started On',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(183, 183, 183, 1),
            ),
          ),
        ),
        Text(
          convertDateFormat(dateString),
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(183, 183, 183, 1),
            ),
          ),
        ),
      ],
    );
  }
}
