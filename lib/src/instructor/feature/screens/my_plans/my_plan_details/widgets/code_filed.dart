import 'package:flutter/material.dart';

class GenerateCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  const GenerateCodeField(
      {super.key, this.controller, this.autovalidateMode, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        errorStyle: const TextStyle(fontSize: 0.01),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(6.0),
        //   borderSide: const BorderSide(
        //     width: 1.0,
        //   ),
        // ),
        // errorStyle: const TextStyle(fontSize: 0.01),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(6.0),
        //   borderSide: const BorderSide(
        //     color: Color.fromRGBO(208, 208, 208, 1),
        //     width: 1.0,
        //   ),
        // ),
        contentPadding: const EdgeInsets.only(left: 4, bottom: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
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
