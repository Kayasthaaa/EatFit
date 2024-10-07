// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/page/profile.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/user/feature/screen/my_meal_plans/screen/user_my_meal_plans.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/page/user_mean_invitation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key});

  @override
  _UserBottomNavigationState createState() => _UserBottomNavigationState();
}

class _UserBottomNavigationState extends State<UserBottomNavigation> {
  final _controller = PersistentTabController(initialIndex: 0);
  late int _userId;
  bool _isLoading = true;
  List<Widget> screens() {
    return [
      const UserMealInvitation(),
      const UserMealPlansPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('images/userInvite.png'),
          size: 105,
        ),
        contentPadding: 10,
        textStyle: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('images/userPlan.png'),
          size: 35,
        ),
        contentPadding: 10,
        textStyle: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        activeColorPrimary: Colors.white,
      ),
      _isLoading
          ? PersistentBottomNavBarItem(
              icon: const ImageIcon(
                AssetImage(
                  'images/rect.png',
                ),
                size: 35,
              ),
            )
          : _buildProfileNavBarItem(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens(),
      items: navBarItems(),
      backgroundColor: const Color.fromRGBO(69, 194, 240, 1),
      navBarStyle: NavBarStyle.style14,
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

  PersistentBottomNavBarItem _buildProfileNavBarItem() {
    return PersistentBottomNavBarItem(
      iconSize: 35,
      icon: BlocProvider(
        create: (context) =>
            GetProfileDetailsCubit(_userId)..getProfileDetails(id: _userId),
        child: BlocBuilder<GetProfileDetailsCubit, GetProfileDetailsState>(
          builder: (context, state) {
            if (state.status == GetProfileDetailsStatus.loading) {
              return const SizedBox.shrink();
            } else if (state.status == GetProfileDetailsStatus.success) {
              final _details = state.plans;
              return _details!.profilePicture == null
                  ? Containers(
                      width: 32,
                      height: 25,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.asset(
                                  'images/rect.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2.9),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Profile',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Containers(
                      width: 32,
                      height: 25,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: CachedNetworkImage(
                                  imageUrl: _details.profilePicture!,
                                  fit: BoxFit.fill,
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
                          const SizedBox(height: 2.9),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Profile',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            } else if (state.status == GetProfileDetailsStatus.error) {
              return const ImageIcon(
                AssetImage(
                  'images/rect.png',
                ),
                size: 35,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      contentPadding: 10,
      textStyle: GoogleFonts.inter(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
      activeColorPrimary: Colors.white,
    );
  }
}
