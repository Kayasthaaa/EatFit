// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unused_field, use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/loader.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/constant/validations.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/earnings_tab/cubit/earning_details_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/cubit/get_payout_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earnings/cubit/get_earnings_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_subscribers/cubit/get_subscribers_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/in_app_notification/cubit/in_app_notification_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/invite_code/cubit/auth_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/my_plans/my_plans/cubit/get_plans_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/profile/cubit/get_profile_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/cubit/update_profile_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/widgets/logoutBtn.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/widgets/picture_container.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/widgets/update_profile_filed.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late int _userId;
  bool _isLoading = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isName = true;
  bool isBio = true;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void updateFormFields(String? fullName, String? bio) {
    setState(() {
      nameController.text = fullName ?? '';
      bioController.text = bio ?? '';
    });
  }

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  String? imagePath;

  Future<PermissionStatus> _requestPermission(ImageSource source) async {
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.photos,
      ].request();

      PermissionStatus cameraPermissionStatus =
          statuses[Permission.camera] ?? PermissionStatus.denied;
      PermissionStatus photosPermissionStatus =
          statuses[Permission.photos] ?? PermissionStatus.denied;

      if (source == ImageSource.camera &&
          cameraPermissionStatus == PermissionStatus.granted) {
        return PermissionStatus.granted;
      } else if (source == ImageSource.gallery &&
          photosPermissionStatus == PermissionStatus.granted) {
        return PermissionStatus.granted;
      } else {
        return PermissionStatus.denied;
      }
    } else {
      final permission = source == ImageSource.camera
          ? Permission.camera
          : (Platform.isAndroid &&
                  (await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32)
              ? Permission.storage
              : Permission.photos;
      final status = await permission.request();
      return status;
    }
  }

  void _showPermissionDeniedDialog(ImageSource source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(source == ImageSource.camera
              ? 'Camera Permission Denied'
              : 'Gallery Permission Denied'),
          content: const Text(
              'Please grant permission to access the selected source.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  Future _getImageCamera() async {
    final permissionStatus = await _requestPermission(ImageSource.camera);

    if (permissionStatus == PermissionStatus.granted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        setState(() {
          imagePath = pickedFile.path;
          this.imageFile = imageFile;
          isBio = false;
          isName = false;
        });
      }
    } else {
      _showPermissionDeniedDialog(ImageSource.camera);
    }
  }

  Future pickGal() async {
    final permissionStatus = await _requestPermission(ImageSource.gallery);

    if (permissionStatus == PermissionStatus.granted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        setState(() {
          imagePath = pickedFile.path;
          this.imageFile = imageFile;
          isBio = false;
          isName = false;
        });
      }
    } else {
      _showPermissionDeniedDialog(ImageSource.gallery);
    }
  }

  Future<void> _refreshProfileDetails(BuildContext context) async {
    // Pass the context to access the GetProfileDetailsCubit
    BlocProvider.of<GetProfileDetailsCubit>(context)
        .getProfileDetails(id: _userId);
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
              child:
                  BlocBuilder<GetProfileDetailsCubit, GetProfileDetailsState>(
                builder: (context, state) {
                  if (state.status == GetProfileDetailsStatus.loading) {
                    return Center(
                      child: AppLoading(),
                    );
                  } else if (state.status == GetProfileDetailsStatus.success) {
                    final _details = state.plans;
                    return BlocBuilder<GetProfileDetailsCubit,
                        GetProfileDetailsState>(
                      builder: (context, state) {
                        return RefreshIndicator(
                          onRefresh: () => _refreshProfileDetails(context),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 25.0),
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
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    PictureContainer(
                                      width: 100,
                                      height: 100,
                                      child: imagePath == null
                                          ? _details!.profilePicture == null
                                              ? Image.asset(
                                                  'images/rect.png',
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                )
                                              : FullScreenWidget(
                                                  disposeLevel:
                                                      DisposeLevel.Medium,
                                                  child: CachedNetworkImage(
                                                    imageUrl: _details
                                                        .profilePicture!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (_, __, ___) {
                                                      return Image.asset(
                                                        'images/rect.png',
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                )
                                          : Image.file(
                                              File(imagePath!),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(height: 4),
                                    Containers(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 120,
                                              width: maxWidth(context),
                                              color: Colors.grey.shade200,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _getImageCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 80,
                                                      width: 75,
                                                      decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.1),
                                                            blurRadius: 5.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                Offset(0, 0),
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.camera,
                                                            size: 30,
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Texts(
                                                            texts: 'Camera',
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30),
                                                  GestureDetector(
                                                    onTap: () {
                                                      pickGal();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.1),
                                                            blurRadius: 5.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                Offset(0, 0),
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.image,
                                                            size: 30,
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Texts(
                                                            texts: 'Gallery',
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      width: maxWidth(context),
                                      height: 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Texts(
                                            texts: 'Change Profile Picture',
                                            fontSize: 7,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 163, 163, 163),
                                          ),
                                          const SizedBox(width: 4),
                                          Image.asset(
                                            'images/pen.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    UpdateFileds(
                                      validator: validateEmptyName,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      texts: 'Your Name',
                                      hintText: _details?.fullName ??
                                          'Your Name Here',
                                      prefixIcon:
                                          const Icon(Icons.manage_accounts),
                                      readOnly: isName,
                                      controller: nameController,
                                      suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isName = !isName;
                                            isBio = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    UpdateFileds(
                                      texts: 'Your Number',
                                      hintText: _details?.phoneNumber ??
                                          'Your Number Here',
                                      prefixIcon: const Icon(Icons.phone),
                                      readOnly: true,
                                    ),
                                    UpdateFileds(
                                      texts: 'Your Role',
                                      hintText: _details?.roleType ??
                                          'Your Role Here',
                                      prefixIcon:
                                          const Icon(Icons.sports_gymnastics),
                                      readOnly: true,
                                    ),
                                    UpdateFileds(
                                      controller: bioController,
                                      texts: 'Your Bio',
                                      maxLines: 3,
                                      inputType: TextInputType.multiline,
                                      hintText:
                                          _details?.bio ?? 'Your Bio here',
                                      prefixIcon:
                                          const Icon(Icons.info_outline),
                                      readOnly: isBio,
                                      suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isBio = !isBio;
                                            isName = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Containers(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 22),
                                      width: maxWidth(context),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Containers(
                                              onTap: () {
                                                setState(() {
                                                  isName = true;
                                                  isBio = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.black54,
                                              ),
                                              child: const Center(
                                                child: Texts(
                                                  texts: 'Cancel',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          BlocProvider(
                                            create: (context) =>
                                                UpdateProfileCubit(),
                                            child: BlocConsumer<
                                                UpdateProfileCubit,
                                                UpdateProfileState>(
                                              listener: (context, state) {
                                                if (state.status ==
                                                    UpdateProfileStatus
                                                        .success) {
                                                  updateFormFields(
                                                      state.plans!.fullName,
                                                      state.plans!.bio);
                                                  ToasterService.success(
                                                      message:
                                                          'Your Details has been updated');
                                                } else if (state.status ==
                                                    UpdateProfileStatus.error) {
                                                  ToasterService.error(
                                                      message:
                                                          'Error, please try again later');
                                                }
                                              },
                                              builder: (context, state) {
                                                return Expanded(
                                                  child: Containers(
                                                    onTap: () async {
                                                      var connectivityResult =
                                                          await Connectivity()
                                                              .checkConnectivity();
                                                      if (connectivityResult ==
                                                          ConnectivityResult
                                                              .none) {
                                                        ToasterService.error(
                                                            message:
                                                                'No internet connection');
                                                      } else {
                                                        if (imageFile != null ||
                                                            isBio == false ||
                                                            isName == false) {
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            context
                                                                .read<
                                                                    UpdateProfileCubit>()
                                                                .updateProfile(
                                                                  nameController
                                                                          .text
                                                                          .isEmpty
                                                                      ? _details!
                                                                          .fullName
                                                                          .toString()
                                                                      : nameController
                                                                          .text,
                                                                  bioController
                                                                          .text
                                                                          .isEmpty
                                                                      ? _details!
                                                                          .bio
                                                                          .toString()
                                                                      : bioController
                                                                          .text,
                                                                  imageFile,
                                                                );
                                                          });
                                                        } else {
                                                          ToasterService.error(
                                                              message:
                                                                  'Please update your details');
                                                        }
                                                      }
                                                    },
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.teal,
                                                    ),
                                                    child: Center(
                                                      child: state.status ==
                                                              UpdateProfileStatus
                                                                  .loading
                                                          ? loading()
                                                          : const Texts(
                                                              texts: 'Update',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    LogoutBtn(
                                      context,
                                      () async {
                                        context
                                            .read<GetSubscribersCubit>()
                                            .cancelOngoingCalls();
                                        context
                                            .read<GetPayoutCubit>()
                                            .cancelOngoingCalls();
                                        context
                                            .read<GetEarningsCubit>()
                                            .cancelOngoingCalls();
                                        context
                                            .read<GetEarningDetailsCubit>()
                                            .cancelOngoingCalls();

                                        context
                                            .read<GetPlansCubit>()
                                            .cancelOngoingCalls();
                                        context
                                            .read<NotificationCubit>()
                                            .cancelOngoingCalls();
                                        await context
                                            .read<NotificationCubit>()
                                            .close();

                                        await context
                                            .read<GetEarningDetailsCubit>()
                                            .close();
                                        await context
                                            .read<GetSubscribersCubit>()
                                            .close();
                                        await context
                                            .read<GetEarningDetailsCubit>()
                                            .close();
                                        await context
                                            .read<GetPayoutCubit>()
                                            .close();
                                        await context
                                            .read<GetEarningsCubit>()
                                            .close();

                                        await context
                                            .read<GetPlansCubit>()
                                            .close();

                                        BlocProvider.of<AuthCubit>(context)
                                            .logout();
                                      },
                                    ),
                                    const SizedBox(height: 35),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
    );
  }

  Future<void> _loadUserId() async {
    SharedPreferences userId = await SharedPreferences.getInstance();
    setState(() {
      _userId = userId.getInt('id') ?? 0;
      _isLoading = false;
    });
  }
}
