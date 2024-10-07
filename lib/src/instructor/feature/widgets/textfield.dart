import 'package:flutter/material.dart';

class MealField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autovalidateMode;
  final String? title;
  final String? hintText;
  final TextEditingController? mealController;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextStyle? textFieldStyle;
  final TextInputType? inputType;
  final bool isPassword;
  final int? maxLines;
  final Function()? onTap;
  final bool isDisabled;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextStyle? labelStyle;

  const MealField({
    super.key,
    this.title,
    this.mealController,
    this.border,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.textFieldStyle,
    this.inputType,
    this.isPassword = false,
    this.maxLines,
    this.onTap,
    this.isDisabled = false,
    this.readOnly = false,
    this.suffix,
    this.validator,
    this.labelText,
    this.labelStyle,
    this.onChanged,
    this.onSaved,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          autofocus: false,
          maxLines: maxLines ?? 1,
          style: textFieldStyle,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
            setState(() {}); // This will rebuild only this TextFormField
          },
          onSaved: onSaved,
          autovalidateMode: autovalidateMode,
          controller: mealController,
          readOnly: readOnly,
          validator: validator,
          keyboardType: inputType,
          obscureText: isPassword,
          obscuringCharacter: '*',
          decoration: InputDecoration(
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
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffix,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
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
      },
    );
  }
}
