// ignore_for_file: library_private_types_in_public_api, unused_element, prefer_const_constructors, unused_local_variable

import 'package:eat_fit/src/instructor/constant/app_spaces.dart';
import 'package:eat_fit/src/instructor/constant/colors.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/fancy_texts.dart';
import 'package:eat_fit/src/user/feature/screen/my_meal_plans/widget/user_meal_container.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/cubit/user_subscriber_details_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/cubit/user_subscriber_details_state.dart';
import 'package:eat_fit/src/user/feature/screen/user_subscriber_details/screen/widgets/read_more_ex.dart';
import 'package:eat_fit/src/user/feature/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserSubscriberDetailsPage extends StatefulWidget {
  final String name;
  final String firstW;
  final String mealName;
  final int id;
  const UserSubscriberDetailsPage(
      {super.key,
      required this.id,
      required this.name,
      required this.firstW,
      required this.mealName});

  @override
  _UserSubscriberDetailsPageState createState() =>
      _UserSubscriberDetailsPageState();
}

class _UserSubscriberDetailsPageState extends State<UserSubscriberDetailsPage> {
  bool _showAllUpcoming = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const kAppBar(),
      ),
      body: BlocProvider(
        create: (context) => UsersubscriberDetailsCubit(widget.id)
          ..getUserSubscriberDetails(id: widget.id),
        child:
            BlocBuilder<UsersubscriberDetailsCubit, UsersubscriberDetailsState>(
          builder: (context, state) {
            if (state.status == UsersubscriberDetailsStatus.loading) {
              return Center(child: AppLoading());
            } else if (state.status == UsersubscriberDetailsStatus.success) {
              final data = state.plans;
              return data!.isEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: const [
                        SizedBox(height: 250),
                        Center(child: FancyText()),
                      ],
                    )
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26),
                          width: maxWidth(context),
                          child: const Texts(
                            texts: 'My Meal Plans Details',
                            color: AppColor.kTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, int index) {
                            DateTime createdAt = DateTime.parse(data[index]
                                .days![index]
                                .mealsOfTheDay![index]
                                .createdAt!);
                            int mealTimes =
                                data[index].subscription!.numberOfDays!;

                            DateTime createdAtDate = DateTime(
                                createdAt.year, createdAt.month, createdAt.day);
                            DateTime now = DateTime.now();
                            DateTime nowDate =
                                DateTime(now.year, now.month, now.day);

                            final daysPassed =
                                nowDate.difference(createdAtDate).inDays;
                            final progress =
                                (daysPassed / mealTimes).clamp(0.0, 1.0);

                            final days = data[index].days!;
                            days.sort((a, b) => a.day!.compareTo(b.day!));

                            final upcomingDays = days.where((day) {
                              final deliveryDate =
                                  DateTime.parse(day.deliveredDate!);
                              return deliveryDate.isAfter(nowDate) ||
                                  deliveryDate.isAtSameMomentAs(nowDate);
                            }).toList();

                            final goneDays = days.where((day) {
                              final deliveryDate =
                                  DateTime.parse(day.deliveredDate!);
                              return deliveryDate.isBefore(nowDate);
                            }).toList();

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UserMealContainer(
                                    onTap: () {},
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    created: data[index]
                                        .days![index]
                                        .mealsOfTheDay![index]
                                        .createdAt!,
                                    planName: widget.mealName,
                                    numberOfDays: data[index]
                                        .subscription!
                                        .numberOfDays
                                        .toString(),
                                    firstWord: widget.firstW,
                                    url: data[index].subscription!.photo ?? '',
                                    instructor: widget.name,
                                    time: data[index]
                                        .subscription!
                                        .numberOfDays
                                        .toString(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LinearProgressIndicator(
                                          minHeight: 6,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          value: progress,
                                          backgroundColor: Colors.grey[200],
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 26),
                                    width: maxWidth(context),
                                    child: const Texts(
                                      texts: 'Next Meal In This Plan',
                                      color: AppColor.kTitleColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  if (upcomingDays.isNotEmpty) ...[
                                    _buildDayContainer(
                                      upcomingDays[1],
                                      true,
                                      data[index].days![index].day.toString(),
                                    ),
                                    if (upcomingDays.length > 1)
                                      Center(
                                        child: Texts(
                                          onTap: () {
                                            setState(() {
                                              _showAllUpcoming =
                                                  !_showAllUpcoming;
                                            });
                                          },
                                          texts: _showAllUpcoming
                                              ? 'HIDE THE MEALS'
                                              : 'SEE ALL MEALS',
                                          decoration: TextDecoration.underline,
                                          underlineColor: AppColor.kTitleColor,
                                          color: AppColor.kTitleColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    SizedBox(height: 6),
                                    if (_showAllUpcoming)
                                      ...upcomingDays.skip(1).map(
                                            (day) => _buildDayContainer(
                                                day,
                                                true,
                                                data[index]
                                                    .days![index]
                                                    .day
                                                    .toString()),
                                          ),
                                  ],
                                  SizedBox(height: 20),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 26),
                                    width: maxWidth(context),
                                    child: const Texts(
                                      texts: 'Previous Meal From The Plan',
                                      color: AppColor.kTitleColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ...goneDays.map((day) => _buildDayContainer(
                                      day,
                                      false,
                                      data[index].days![index].day.toString())),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    );
            } else if (state.status == UsersubscriberDetailsStatus.error) {
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

  Widget _buildDayContainer(dynamic day, bool isUpcoming, String days) {
    final deliveryDate = DateTime.parse(day.deliveredDate);
    final now = DateTime.now();
    final isToday = deliveryDate.year == now.year &&
        deliveryDate.month == now.month &&
        deliveryDate.day == now.day;

    final dayNumber = int.tryParse(day.day.toString()) ?? 0;

    // Sort meals by meal_time
    day.mealsOfTheDay.sort((a, b) {
      final timeA = TimeOfDay(
        hour: int.parse(a.mealTime.split(':')[0]),
        minute: int.parse(a.mealTime.split(':')[1]),
      );
      final timeB = TimeOfDay(
        hour: int.parse(b.mealTime.split(':')[0]),
        minute: int.parse(b.mealTime.split(':')[1]),
      );
      return timeA.hour * 60 + timeA.minute - (timeB.hour * 60 + timeB.minute);
    });

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 80.0,
      ),
      child: Container(
        width: maxWidth(context),
        margin: EdgeInsets.only(left: 22, right: 22, bottom: 15),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              texts: 'DAY $dayNumber',
              color: Color.fromRGBO(234, 93, 36, 1),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8),
            ...day.mealsOfTheDay.map(
              (meal) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextApp(
                          texts: '${_formatTime(meal.mealTime)}  ',
                          fontWeight: FontWeight.w700,
                          fontSize:
                              meal.orderProgress == 'On_the_way' ? 15 : 13,
                          color: meal.orderProgress == 'On_the_way'
                              ? Colors.black
                              : Color.fromRGBO(183, 183, 183, 1),
                        ),
                        SizedBox(width: 10),
                        _buildStatusIndicator(meal.orderProgress),
                      ],
                    ),
                    SizedBox(height: 4),
                    ReadMoreSub(
                      texts: meal.mealDetails,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color containerColor;
    String displayText;

    switch (status) {
      case 'Delivered':
        containerColor = Colors.green;
        displayText = 'Delivered';
        break;
      case 'On_the_way':
        containerColor = Colors.blue;
        displayText = 'Upcoming';
        break;
      case 'Cooking':
      case 'Not_ready':
        containerColor = Colors.orange;
        displayText = 'Later';
        break;
      default:
        containerColor = Colors.grey;
        displayText = status;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 60.0, // Set the minimum width
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextApp(
              texts: displayText,
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('MMMM d, y').format(date);
  }

  String _formatTime(String timeString) {
    final time = TimeOfDay(
      hour: int.parse(timeString.split(':')[0]),
      minute: int.parse(timeString.split(':')[1]),
    );
    return time.format(context);
  }
}
