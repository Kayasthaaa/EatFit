import 'package:flutter/material.dart';

class StateField extends StatelessWidget {
  final TextEditingController? controller;
  const StateField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'AM',
        contentPadding: const EdgeInsets.only(left: 13, bottom: 10),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15.0,
          color: Color.fromRGBO(197, 196, 196, 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        errorStyle: const TextStyle(fontSize: 0.01),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
              color: Color.fromRGBO(208, 208, 208, 1), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
              color: Color.fromRGBO(208, 208, 208, 1), width: 1),
        ),
      ),
    );
  }
}
