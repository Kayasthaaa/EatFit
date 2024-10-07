import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onPressed;
  const TimeContainer(
      {super.key, this.validator, this.controller, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Please add time',
        suffixIcon: IconButton(
            icon: Icon(
              Icons.timer,
              color: Colors.grey.shade600,
            ),
            onPressed: onPressed),
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
