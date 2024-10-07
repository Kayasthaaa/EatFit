// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/screen/get_earnings.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/page/get_earnings.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/widgets/profile_plans.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/widgets/user_profile_meals.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/page/update_profile.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int _userId;
  bool _isLoading = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _refreshData(BuildContext context) async {
    final List<Future<void>> futures = [
      BlocProvider.of<GetPlansCubit>(context).getPlans(),
      BlocProvider.of<GetEarningsCubit>(context).getEarnings(),
      BlocProvider.of<GetSubscribersCubit>(context).getSubscribers(),
      BlocProvider.of<GetProfileDetailsCubit>(context)
          .getProfileDetails(id: _userId),
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
      body: _isLoading
          ? Center(
              child: AppLoading(),
            )
          : BlocProvider(
              create: (_) => GetProfileDetailsCubit(_userId)
                ..getProfileDetails(id: _userId),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => GetPlansCubit()..getPlans(),
                  ),
                  BlocProvider(
                    create: (_) => GetEarningsCubit()..getEarnings(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GetSubscribersCubit()..getSubscribers(),
                  ),
                ],
                child:
                    BlocBuilder<GetProfileDetailsCubit, GetProfileDetailsState>(
                  builder: (context, state) {
                    if (state.status == GetProfileDetailsStatus.loading) {
                      return Center(
                        child: AppLoading(),
                      );
                    } else if (state.status ==
                        GetProfileDetailsStatus.success) {
                      final _details = state.plans;
                      return RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: () => _refreshData(context),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          children: [
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Texts(
                                texts: 'My Profile',
                                fontSize: 11,
                                color: AppColor.kTitleColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Containers(
                              width: maxWidth(context),
                              height: 90,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Containers(
                                    width: 85,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _details!.profilePicture == null
                                          ? Image.asset(
                                              'images/rect.png',
                                              fit: BoxFit.fill,
                                            )
                                          : FullScreenWidget(
                                              disposeLevel: DisposeLevel.Medium,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    _details.profilePicture!,
                                                fit: BoxFit.cover,
                                                errorWidget: (_, __, ___) {
                                                  return Image.asset(
                                                    'images/rect.png',
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Containers(
                                      height: 90,
                                      child: Column(
                                        children: [
                                          Containers(
                                            width: maxWidth(context),
                                            height: 15,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Texts(
                                                    texts: _details.fullName ??
                                                        'Your Name here',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Containers(
                                                    onTap: () {
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                        context,
                                                        screen:
                                                            const UpdateProfilePage(),
                                                        withNavBar: true,
                                                      );
                                                    },
                                                    width: 22,
                                                    height: 30,
                                                    child: Image.asset(
                                                      'images/pen.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Texts(
                                              texts:
                                                  _details.roleType.toString(),
                                              color: const Color.fromRGBO(
                                                  183, 183, 183, 1),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 50,
                                              color: Colors.transparent,
                                              child: Texts(
                                                overflow: TextOverflow.ellipsis,
                                                texts: _details.bio ??
                                                    'Your bio here',
                                                maxLines: 3,
                                                color: const Color.fromRGBO(
                                                    183, 183, 183, 1),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            _details.roleType == 'Normal'
                                ? const UserMealPlansProfilePage()
                                : GetEarningsPage(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const GetEarningDetailsPage(),
                                        withNavBar: true,
                                      );
                                    },
                                  ),
                            const MyProfilePlansUI(
                              padding: EdgeInsets.only(bottom: 25),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    } else if (state.status == GetProfileDetailsStatus.error) {
                      return const Center(
                        child: ErrorTexts(texts: 'No internet connection'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
    );
  }

  Future<void> _loadUserId() async {
    SharedPreferences userId = await SharedPreferences.getInstance();
    setState(
      () {
        _userId = userId.getInt('id') ?? 0;
        _isLoading = false;
      },
    );
  }
}
