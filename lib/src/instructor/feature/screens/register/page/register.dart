// ignore_for_file: library_private_types_in_public_api, prefer_is_empty

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/screens/invite_code/widgets/grid_container.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/page/login_page.dart';
import 'package:eat_fit/src/instructor/feature/screens/register/cubit/register_cubit.dart';
import 'package:eat_fit/src/instructor/feature/widgets/appLogo.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_btn.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/btn_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class Registerpage extends StatefulWidget {
  final String number;
  const Registerpage({
    super.key,
    required this.number,
  });

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Registerpage> {
  late bool _isConnected;
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  String maxLengthString(String str, int maxLength) {
    if (str.length <= maxLength) {
      return str;
    } else {
      return str.substring(0, maxLength);
    }
  }

  String enteredText = '';
  int maxLength = 4;
  String finalString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Containers(
                  height: 70,
                  width: maxWidth(context),
                  child: Center(
                    child: appLogo(BoxFit.fill),
                  ),
                ),
                const SizedBox(height: 15),
                Containers(
                  height: 19,
                  width: maxWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Texts(
                        texts: 'Welcome, ',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(151, 151, 151, 1),
                      ),
                      Texts(
                        texts: widget.number.toString(),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(151, 151, 151, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Texts(
                  texts: 'Set your Access Code',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(151, 151, 151, 1),
                ),
                const SizedBox(height: 20),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  children: [
                    getBox(
                      finalString.length >= 1
                          ? const Color.fromRGBO(142, 136, 136, 1)
                          : const Color.fromRGBO(217, 217, 217, 1),
                    ),
                    getBox(
                      finalString.length >= 2
                          ? const Color.fromRGBO(142, 136, 136, 1)
                          : const Color.fromRGBO(217, 217, 217, 1),
                    ),
                    getBox(
                      finalString.length >= 3
                          ? const Color.fromRGBO(142, 136, 136, 1)
                          : const Color.fromRGBO(217, 217, 217, 1),
                    ),
                    getBox(
                      finalString.length >= 4
                          ? const Color.fromRGBO(142, 136, 136, 1)
                          : const Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ListView(
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Containers(
                          width: maxWidth(context),
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GridContainer('1', () {
                                setState(() {
                                  enteredText = enteredText + 1.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('2', () {
                                setState(() {
                                  enteredText = enteredText + 2.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('3', () {
                                setState(() {
                                  enteredText = enteredText + 3.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Containers(
                          width: maxWidth(context),
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GridContainer('4', () {
                                setState(() {
                                  enteredText = enteredText + 4.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('5', () {
                                setState(() {
                                  enteredText = enteredText + 5.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('6', () {
                                setState(() {
                                  enteredText = enteredText + 6.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Containers(
                          width: maxWidth(context),
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GridContainer('7', () {
                                setState(() {
                                  enteredText = enteredText + 7.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('8', () {
                                setState(() {
                                  enteredText = enteredText + 8.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                              GridContainer('9', () {
                                setState(() {
                                  enteredText = enteredText + 9.toString();
                                  finalString =
                                      maxLengthString(enteredText, maxLength);
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Containers(
                          width: maxWidth(context),
                          height: 70,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Containers(
                              width: maxWidth(context) / 2.25,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GridContainer('0', () {
                                    setState(() {
                                      enteredText = enteredText + 0.toString();
                                      finalString = maxLengthString(
                                          enteredText, maxLength);
                                    });
                                  }),
                                  GridContainer('<', () {
                                    setState(() {
                                      if (finalString.isNotEmpty) {
                                        finalString = finalString.substring(
                                            0, finalString.length - 1);
                                      }
                                      if (enteredText.isNotEmpty) {
                                        enteredText = enteredText.substring(
                                            0, enteredText.length - 1);
                                      }
                                    });
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return AppBtn(
                onTap: () async {
                  if (_isConnected) {
                    if (finalString.length < 4) {
                      setState(() {
                        errorMessage = 'Access code should not be of 4 digits';
                      });
                    } else {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.none) {
                        setState(() {
                          errorMessage = 'No internet connection';
                        });
                        return;
                      }

                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                          context.read<RegisterCubit>().registerUser(
                              widget.number.toString(),
                              finalString.toString(),
                              finalString.toString());
                        },
                      );
                    }
                  }
                },
                child:
                    state is RegsiterLoading ? loading() : btnText('Proceed'),
              );
            },
            listener: (BuildContext context, RegisterState state) {
              if (state is RegsiterError) {
                setState(() {
                  errorMessage = state.errorMessage;
                });
              } else if (state is RegsiterSuccess) {
                setState(() {
                  errorMessage = null;
                });
                Get.off(
                  () => const LoginPage(),
                );
                ToasterService.success(message: 'Please proceed to login');
              }
            },
          ),
        ));
  }

  Widget getBox(Color color) {
    return Container(
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
