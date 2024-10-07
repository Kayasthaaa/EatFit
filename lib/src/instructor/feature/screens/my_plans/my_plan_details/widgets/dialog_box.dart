// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void showAlertDialog(BuildContext context, String? texts, String copiedTexts,
    String link, String mealName, String userNum) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Containers(
            width: maxWidth(context),
            height: 200,
            child: Column(
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Texts(
                    texts: 'Share Link Generated',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(88, 195, 202, 1),
                  ),
                ),
                const SizedBox(height: 25),
                Containers(
                  height: 30,
                  width: maxWidth(context),
                  child: Texts(
                    texts: texts ?? 'User has been invited',
                    fontSize: 17,
                    color: const Color.fromRGBO(183, 183, 183, 1),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Containers(
                  width: maxWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Containers(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: copiedTexts))
                              .then((result) {
                            ToasterService.copied(
                                message: "Copied to clipboard");
                          });
                        },
                        height: 39,
                        width: maxWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(88, 195, 202, 1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Texts(
                                texts: 'Copy Link',
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Containers(
                        onTap: () async {
                          final SharedPreferences userName =
                              await SharedPreferences.getInstance();
                          String? name = userName.getString('Name');
                          final url = Uri.encodeFull(
                              "sms:$userNum?body=You've been invited to order meal $mealName. Login to eatfit app to see the details. Your code: $link");

                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        height: 39,
                        width: maxWidth(context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(255, 109, 177, 115)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Texts(
                                texts: 'Send via SMS',
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
