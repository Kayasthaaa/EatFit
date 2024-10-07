import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/cubit/user_invitations_state.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/widgets/meal_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/cubit/user_meal_plan_details_cubit.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/cubit/user_meal_plan_details_state.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_loading.dart';
import 'package:eat_fit/src/instructor/feature/widgets/error_text.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_bar.dart';

class MealPlanDetailsPage extends StatelessWidget {
  final int id;

  const MealPlanDetailsPage({
    super.key,
    required this.id,
  });

  Future<void> _refresh(BuildContext context) async {
    context.read<GetUserPlansDetailsCubit>().getUserPlansDetails(id: id);
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
                GetUserPlansDetailsCubit(id)..getUserPlansDetails(id: id),
          ),
          BlocProvider(
            create: (context) => GetInvitationsCubit()..getInvitations(),
          ),
        ],
        child: BlocBuilder<GetUserPlansDetailsCubit, GetUserPlansDetailsState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: state.status == GetUserPlansDetailsStatus.loading
                  ? Center(
                      child: AppLoading(),
                    )
                  : state.status == GetUserPlansDetailsStatus.success
                      ? BlocBuilder<GetInvitationsCubit, GetInvitationsState>(
                          builder: (context, invstate) {
                            if (invstate.status ==
                                GetInvitationStatus.success) {
                              final inv = invstate.plans;
                              return MealPlanContent(state.plans!,
                                  models: inv![0]);
                            } else {
                              return Container();
                            }
                          },
                        )
                      : const Center(
                          child: ErrorTexts(
                            texts: 'No internet connection',
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
