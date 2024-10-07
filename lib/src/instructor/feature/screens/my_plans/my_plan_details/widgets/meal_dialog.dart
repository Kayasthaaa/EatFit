import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:flutter/material.dart';

void showMealDialog(
    BuildContext context, Widget child, TextEditingController? controller) {
  showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Texts(
                    texts: 'Change meal name',
                    color: Color.fromRGBO(183, 183, 183, 1),
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'New meal name',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        isCollapsed: true,
                      ),
                      validator: validateFields,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container(); // Placeholder return statement
    },
  );
}
