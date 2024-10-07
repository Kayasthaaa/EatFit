import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/invite_code/page/invite_code.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/cubit/login_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/widgets/dialog_box.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/widgets/dialog_btn.dart';
import 'package:eat_fit/src/instructor/feature/screens/redeem_code/cubit/redeem_code_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/register/page/register.dart';
import 'package:eat_fit/src/instructor/feature/widgets/appLogo.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_btn.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/btn_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyCode = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    verifyCode.dispose();
    phoneFocusNode.dispose();
  }

  void unfocusKeyboard() {
    phoneFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAppSpacing),
          child: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                children: [
                  const SizedBox(height: 180),
                  appLogo(BoxFit.fill),
                  const SizedBox(height: 60),
                  Containers(
                    width: maxWidth(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Containers(
                          width: maxWidth(context),
                          child: const Texts(
                            texts: 'Enter Your Mobile Number',
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColor.ktextColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: phoneController,
                                focusNode: phoneFocusNode,
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: AppColor.kbtnColor,
                                ),
                                validator: validateNumber,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.phone,
                              ),
                              if (errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Text(
                                    errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Containers(
                    height: 50,
                    width: maxWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Texts(
                          texts: 'OR',
                          fontWeight: FontWeight.w400,
                          color: AppColor.ktextColor,
                          fontSize: 15,
                        ),
                        BlocProvider(
                          create: (BuildContext context) => RedeemCodeCubit(),
                          child: BlocConsumer<RedeemCodeCubit, RedeemCodeState>(
                            listener: (context, codeState) {
                              if (codeState is RedeemCodeError) {
                                ToasterService.error(
                                    message:
                                        'Invite code is invalid or expired');
                                verifyCode.clear();
                              } else if (codeState is RedeemCodeSuccess) {
                                if (codeState.redeemCodeModels.userexist ==
                                    false) {
                                  Get.off(
                                    () => Registerpage(
                                      number: codeState.redeemCodeModels.number
                                          .toString(),
                                    ),
                                  );
                                } else {
                                  Get.to(
                                    () => InviteCodePage(
                                      number: codeState.redeemCodeModels.number
                                          .toString(),
                                    ),
                                  );
                                }

                                verifyCode.clear();
                                ToasterService.success(
                                    message:
                                        'Code Verified, please verify your number');
                              }
                            },
                            builder: (context, codeState) {
                              return Texts(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return dialogBox(
                                        context,
                                        validateFields,
                                        AutovalidateMode.onUserInteraction,
                                        verifyCode,
                                        DialogBtn(
                                          onTap: () async {
                                            if (verifyCode.text.isEmpty) {
                                              ToasterService.error(
                                                  message:
                                                      'Enter a valid code');
                                            } else {
                                              var connectivityResult =
                                                  await (Connectivity()
                                                      .checkConnectivity());
                                              if (connectivityResult ==
                                                  ConnectivityResult.none) {
                                                ToasterService.error(
                                                    message:
                                                        'No internet connection');
                                                return;
                                              }

                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                (_) {
                                                  context
                                                      .read<RedeemCodeCubit>()
                                                      .redeemCode(
                                                        verifyCode.text
                                                            .toString(),
                                                      );
                                                },
                                              );
                                            }
                                          },
                                          child: codeState is RedeemCodeLoading
                                              ? loading()
                                              : btnText('Proceed'),
                                        ),
                                      );
                                    },
                                  );
                                },
                                texts: 'ENTER AN INVITE CODE',
                                fontWeight: FontWeight.w700,
                                color: AppColor.ktextColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              setState(() {
                errorMessage = 'Phone number does not exist';
              });
            } else if (state is LoginSuccess) {
              setState(() {
                errorMessage = null;
              });
              Get.to(
                () => InviteCodePage(
                  number: state.loginModels.validNumber.toString(),
                ),
              );
            }
          },
          builder: (context, state) {
            return AppBtn(
              onTap: () async {
                unfocusKeyboard(); // Unfocus keyboard here

                final isValid = form.currentState?.validate();
                if (!isValid!) {
                  setState(() {
                    errorMessage = 'Please enter your valid number';
                  });
                  return;
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
                      context.read<LoginCubit>().userLogin(
                            phoneController.text.toString(),
                          );
                    },
                  );
                }
              },
              child: state is LoginLoading ? loading() : btnText('Proceed'),
            );
          },
        ),
      ),
    );
  }
}
