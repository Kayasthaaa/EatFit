// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/cubit/generate_code_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/cubit/generate_code_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/cubit/get_plans_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/cubit/get_plans_details_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/code_filed.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/dialog_box.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/generate_link_container.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plan_details/widgets/my_plan_details_container.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/widgets/date.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/cubit/update_meal_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/cubit/update_meal_plans_state.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class MyPlanDetailsPage extends StatefulWidget {
  final int id;
  final int mealDays;
  final String active;
  final String total;
  const MyPlanDetailsPage({
    super.key,
    required this.id,
    required this.mealDays,
    required this.active,
    required this.total,
  });

  @override
  State<MyPlanDetailsPage> createState() => _MyPlanDetailsPageState();
}

class _MyPlanDetailsPageState extends State<MyPlanDetailsPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController meamName = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void dispose() {
    phoneController.dispose();
    meamName.dispose();
    super.dispose();
  }

  Future<void> _refreshData(BuildContext context) async {
    final List<Future<void>> futures = [
      BlocProvider.of<GetPlansDetailsCubit>(context)
          .getPlansDetails(id: widget.id),
      BlocProvider.of<UpdatePlansDetailsCubit>(context)
          .updateMealDetails(name: meamName.text, id: widget.id),
      BlocProvider.of<GetSubscribersCubit>(context).getSubscribers(),
    ];

    await Future.wait(futures);
    _refreshIndicatorKey.currentState?.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GetPlansDetailsCubit(widget.id)..getPlansDetails(id: widget.id),
          ),
          BlocProvider(
            create: (context) =>
                UpdatePlansDetailsCubit(meamName.text, widget.id)
                  ..updateMealDetails(name: meamName.text, id: widget.id),
          ),
          BlocProvider(
            create: (context) => GetSubscribersCubit()..getSubscribers(),
          ),
        ],
        child: BlocBuilder<GetPlansDetailsCubit, GetPlansDetailsState>(
          builder: (context, state) {
            if (state.status == GetPlansDetailsStatus.loading) {
              return Center(
                child: AppLoading(),
              );
            } else if (state.status == GetPlansDetailsStatus.success) {
              final _plan = state.plans;
              return BlocBuilder<GetSubscribersCubit, GetSubscribersState>(
                builder: (context, substate) {
                  if (substate.status == GetSubscribersStatus.loading) {
                    return Center(
                      child: AppLoading(),
                    );
                  } else if (substate.status == GetSubscribersStatus.success) {
                    final sub = substate.subscribers;
                    return RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () => _refreshData(context),
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kAppSpacing),
                        child: Form(
                          key: _form,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Containers(
                                width: maxWidth(context),
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0, horizontal: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Containers(
                                        width: maxWidth(context),
                                        height: 15,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _plan!.verified == 'Approved'
                                                ? const SizedBox.shrink()
                                                : Containers(
                                                    width: 80,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: _plan.verified ==
                                                              'Pending'
                                                          ? Colors
                                                              .yellow.shade700
                                                          : _plan.verified ==
                                                                  'Rejected'
                                                              ? Colors
                                                                  .red.shade600
                                                              : Colors.grey
                                                                  .shade600,
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.4),
                                                        child: FittedBox(
                                                          child: Texts(
                                                            texts: _plan
                                                                .verified
                                                                .toString(),
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            Expanded(
                                              child: Containers(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              titlePadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                              ),
                                                              title: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15.0),
                                                                child:
                                                                    Containers(
                                                                  width: maxWidth(
                                                                      context),
                                                                  height: 189,
                                                                  // color: Colors.white,
                                                                  child: Column(
                                                                    children: [
                                                                      Containers(
                                                                        height:
                                                                            20,
                                                                        width: maxWidth(
                                                                            context),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              meamName.clear();
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.close,
                                                                              weight: 4,
                                                                              color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.3,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            Texts(
                                                                          texts:
                                                                              'Change Meal Name',
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color: Color.fromRGBO(
                                                                              88,
                                                                              195,
                                                                              202,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      const Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            Texts(
                                                                          texts:
                                                                              'Enter New Meal Name :',
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color: Color.fromRGBO(
                                                                              183,
                                                                              183,
                                                                              183,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      GenerateCodeField(
                                                                        autovalidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        controller:
                                                                            meamName,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      BlocProvider(
                                                                        create: (context) => UpdatePlansDetailsCubit(
                                                                            meamName.text,
                                                                            widget.id),
                                                                        child: BlocConsumer<
                                                                            UpdatePlansDetailsCubit,
                                                                            UpdateMealDetailsState>(
                                                                          listener:
                                                                              (context, mealState) {
                                                                            if (mealState.status ==
                                                                                UpdateMealDetailsStatus.success) {
                                                                              meamName.clear();
                                                                              Navigator.pop(context);

                                                                              ToasterService.success(message: 'Meal name has been updated');
                                                                            } else if (mealState.status == UpdateMealDetailsStatus.error && mealState.errorMessage != null) {
                                                                              ToasterService.error(message: state.errorMessage!);
                                                                            }
                                                                          },
                                                                          builder:
                                                                              (context, mealState) {
                                                                            return Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: GestureDetector(
                                                                                onTap: () async {
                                                                                  var connectivityResult = await Connectivity().checkConnectivity();
                                                                                  if (connectivityResult == ConnectivityResult.none) {
                                                                                    ToasterService.error(message: 'No internet connection');
                                                                                  } else {
                                                                                    if (meamName.text.isEmpty) {
                                                                                      ToasterService.error(message: 'Field cannot be empty');
                                                                                    } else {
                                                                                      WidgetsBinding.instance.addPostFrameCallback(
                                                                                        (_) {
                                                                                          context.read<UpdatePlansDetailsCubit>().updateMealDetails(name: meamName.text, id: widget.id);
                                                                                        },
                                                                                      );
                                                                                    }
                                                                                  }
                                                                                },
                                                                                child: GenerateLinkContainer(
                                                                                  child: mealState.status == UpdateMealDetailsStatus.loading
                                                                                      ? loading()
                                                                                      : const FittedBox(
                                                                                          child: Texts(
                                                                                            texts: 'Update Meal Name',
                                                                                            fontSize: 10,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w700,
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((_) {
                                                          meamName.clear();
                                                        });
                                                      },
                                                      child: Image.asset(
                                                          'images/pen.png',
                                                          fit: BoxFit.fill),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (_plan.verified
                                                                .toString() !=
                                                            'Approved') {
                                                          ToasterService.error(
                                                              message:
                                                                  'Your Plans has not been verified yet');
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                titlePadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.0)),
                                                                ),
                                                                title: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                  child:
                                                                      Containers(
                                                                    width: maxWidth(
                                                                        context),
                                                                    height: 189,
                                                                    // color: Colors.white,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Containers(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              maxWidth(context),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                                phoneController.clear();
                                                                              },
                                                                              child: const Icon(
                                                                                Icons.close,
                                                                                weight: 4,
                                                                                color: Color.fromRGBO(
                                                                                  0,
                                                                                  0,
                                                                                  0,
                                                                                  0.3,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Texts(
                                                                            texts:
                                                                                'Share Meal Plan To',
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Color.fromRGBO(
                                                                                88,
                                                                                195,
                                                                                202,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        const Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Texts(
                                                                            texts:
                                                                                'Enter Phone Number :',
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Color.fromRGBO(
                                                                                183,
                                                                                183,
                                                                                183,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        GenerateCodeField(
                                                                          autovalidateMode:
                                                                              AutovalidateMode.onUserInteraction,
                                                                          validator:
                                                                              validateNumber,
                                                                          controller:
                                                                              phoneController,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        BlocProvider(
                                                                          create: (context) =>
                                                                              GenerateCodeCubit(),
                                                                          child: BlocConsumer<
                                                                              GenerateCodeCubit,
                                                                              GenerateCodeState>(
                                                                            listener:
                                                                                (context, state) {
                                                                              if (state.status == GenerateCodeStatus.success) {
                                                                                Navigator.pop(context);
                                                                                showAlertDialog(context, state.plans!.inviteCode ?? 'User has been invited', state.plans!.inviteCode.toString(), state.plans!.inviteCode.toString(), _plan.planName!, phoneController.text);
                                                                                ToasterService.success(message: 'Code has been created');
                                                                                phoneController.clear();
                                                                              } else if (state.status == GenerateCodeStatus.error && state.errorMessage != null) {
                                                                                ToasterService.error(message: state.errorMessage!);
                                                                              }
                                                                            },
                                                                            builder:
                                                                                (context, state) {
                                                                              return Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: GestureDetector(
                                                                                  onTap: () async {
                                                                                    var connectivityResult = await Connectivity().checkConnectivity();
                                                                                    if (connectivityResult == ConnectivityResult.none) {
                                                                                      ToasterService.error(message: 'No internet connection');
                                                                                    } else {
                                                                                      if (phoneController.text.isEmpty) {
                                                                                        ToasterService.error(message: 'Field cannot be empty');
                                                                                      } else {
                                                                                        WidgetsBinding.instance.addPostFrameCallback(
                                                                                          (_) {
                                                                                            context.read<GenerateCodeCubit>().postCode(_plan.id.toString(), phoneController.text);
                                                                                          },
                                                                                        );
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: GenerateLinkContainer(
                                                                                    child: state.status == GenerateCodeStatus.loading
                                                                                        ? loading()
                                                                                        : const FittedBox(
                                                                                            child: Texts(
                                                                                              texts: 'Generate Share Link',
                                                                                              fontSize: 10,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.w700,
                                                                                            ),
                                                                                          ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((_) {
                                                            phoneController
                                                                .clear();
                                                          });
                                                        }
                                                      },
                                                      child: Image.asset(
                                                          'images/share.png',
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      PlanDetailsContainer(
                                        created: _plan.modifiedAt!,
                                        firstWord: _plan.planName!,
                                        numberOfDays:
                                            _plan.numberOfDays.toString(),
                                        planName: _plan.planName!,
                                        price: _plan.price!,
                                        time:
                                            _plan.mealTimes!.length.toString(),
                                        user: widget.active,
                                        totalSub: widget.total,
                                      ),
                                      const SizedBox(height: 4),
                                      Containers(
                                        width: maxWidth(context),
                                        height: 15,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: DateTextWidget(
                                            dateString:
                                                _plan.modifiedAt.toString(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              widget.active.isEmpty || widget.active == '0'
                                  ? const SizedBox.shrink()
                                  : const SizedBox(height: 20),
                              widget.active.isEmpty || widget.active == '0'
                                  ? const SizedBox.shrink()
                                  : Containers(
                                      width: maxWidth(context),
                                      child: Row(
                                        children: [
                                          const Texts(
                                            texts: 'Active Subscribers',
                                            color: AppColor.kbtnColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                          ),
                                          const SizedBox(width: 5),
                                          Containers(
                                            width: 20,
                                            height: 19,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  101, 199, 55, 1),
                                              borderRadius:
                                                  BorderRadius.circular(7.5),
                                            ),
                                            child: Center(
                                              child: Texts(
                                                texts: widget.active,
                                                fontSize: 6,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              widget.active.isEmpty || widget.active == '0'
                                  ? const SizedBox.shrink()
                                  : const SizedBox(height: 10),
                              widget.active.isEmpty || widget.active == '0'
                                  ? const SizedBox.shrink()
                                  : Container(
                                      width: maxWidth(context),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: sub!.length,
                                        itemBuilder: (_, int subIndex) {
                                          bool isActive =
                                              sub[subIndex].activeStatus ??
                                                  false;
                                          if (isActive) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Texts(
                                                    texts: sub[subIndex]
                                                            .subscriberName ??
                                                        'User',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromRGBO(
                                                        183, 183, 183, 1),
                                                  ),
                                                  const Texts(
                                                    texts: ' | ',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(
                                                        183, 183, 183, 1),
                                                  ),
                                                  Texts(
                                                    texts: sub[subIndex]
                                                        .subscriberNumber
                                                        .toString(),
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromRGBO(
                                                        183, 183, 183, 1),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        },
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              Containers(
                                width: maxWidth(context),
                                child: const Texts(
                                  texts: 'Meal Plan',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.kTitleColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.plans!.meals!.length,
                                itemBuilder: (_, int index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Containers(
                                      width: maxWidth(context),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        border: Border.all(
                                          width: 1.0,
                                          color: const Color.fromRGBO(
                                              240, 240, 240, 1),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 9),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Texts(
                                              texts: 'DAY'
                                                  ' '
                                                  '${_plan.meals![index].day}',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: const Color.fromRGBO(
                                                  234, 93, 36, 1),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                  .plans!
                                                  .meals![index]
                                                  .dayMeals!
                                                  .length,
                                              itemBuilder: (_, int secIndx) {
                                                final _data = state.plans!
                                                    .meals![index].dayMeals;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Texts(
                                                      texts: _data![secIndx]
                                                          .time
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color:
                                                          const Color.fromRGBO(
                                                              183, 183, 183, 1),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    ReadMoreText(
                                                      _data[secIndx]
                                                          .description
                                                          .toString(),
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (substate.status == GetSubscribersStatus.error) {
                    return const Center(
                      child: ErrorTexts(
                        texts: 'No internet connection',
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else if (state.status == GetPlansDetailsStatus.error) {
              return const Center(
                child: ErrorTexts(
                  texts: 'No internet connection',
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
