import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

Widget dialogBox(
  BuildContext context,
  String? Function(String?)? validator,
  AutovalidateMode? autovalidateMode,
  TextEditingController? controller,
  Widget? child,
) {
  return AlertDialog(
    backgroundColor: Colors.white,
    titlePadding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    title: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Containers(
        width: maxWidth(context),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Containers(
              height: 20,
              width: maxWidth(context),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    weight: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Texts(
                  texts: 'Enter your invite code',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColor.kbtnColor),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 60,
                child: CustomTextField(
                  validator: validator,
                  autovalidateMode: autovalidateMode,
                  controller: controller,
                )),
            const SizedBox(height: 20),
            Containers(
              width: maxWidth(context),
              child: child,
            )
          ],
        ),
      ),
    ),
  );
}
