import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/routes/app_routes.dart';
import '../../../../core/config/style/app_color.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../notifications/presentation/manager/notifications_cubit/cubit.dart';
import '../../../notifications/presentation/manager/notifications_cubit/state.dart';
import '../../../notifications/presentation/pages/notifications_view.dart';
import '../../../orders/presentation/pages/active_orders_view.dart';
import '../../../profile/presentation/view_model/profile_cubit/cubit.dart';
import '../../../profile/presentation/view_model/profile_cubit/state.dart';
import '../../../profile/presentation/view/screens/profile_view.dart';
import '../../../profits/presentation/pages/profits_view.dart';
import '../../../trips/presentation/view_model/trips/cubit.dart';
import '../../../trips/presentation/view/screens/active_trips_view.dart';
import '../manager/cubit.dart';
import '../manager/state.dart';
import '../widgets/profile_waiting_review.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            final userVerfied = profileState.currentUser?.status != 0;
            return Scaffold(
              body:
                  profileState.currentUser == null
                      ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                      : userVerfied
                      ? const [
                        ProfileView(),
                        ActiveOrdersView(),
                        ActiveTripsView(),
                        ProfitsView(),
                        NotificationsView(),
                      ][state.index]
                      : const [
                        ProfileView(),
                        ProfileWaitingReview(),
                        ProfileWaitingReview(),
                        ProfitsView(),
                        NotificationsView(),
                      ][state.index],
              floatingActionButton:
                  userVerfied && profileState.currentUser != null
                      ? state.index == 3
                          ? null
                          : FloatingActionButton(
                            onPressed: () async {
                              final tripsCubit = context.read<TripsCubit>();
                              await Navigator.pushNamed(
                                context,
                                AppRoute.createTrip,
                              );
                              tripsCubit.getActiveTrips();
                            },
                            child: const Icon(Icons.add),
                          )
                      : null,
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.desSelected)),
                ),
                child: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (index) {
                    context.read<LayoutCubit>().changeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(Icons.person),
                      ),
                      label: AppStrings.myAccount,
                    ),
                    BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(Icons.shopping_cart),
                      ),
                      label: AppStrings.orders,
                    ),
                    BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(FontAwesomeIcons.road),
                      ),
                      label: AppStrings.trips,
                    ),
                    BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(FontAwesomeIcons.circleDollarToSlot),
                      ),
                      label: AppStrings.myProfit,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: BlocSelector<
                          NotificationsCubit,
                          NotificationsState,
                          int
                        >(
                          selector: (state) {
                            return state.notifications
                                .where((e) => e.isRead == 0)
                                .length;
                          },
                          builder: (context, notificationsCount) {
                            return Badge.count(
                              count: notificationsCount,
                              child: const Icon(Icons.notifications),
                            );
                          },
                        ),
                      ),
                      label: AppStrings.notifications,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
