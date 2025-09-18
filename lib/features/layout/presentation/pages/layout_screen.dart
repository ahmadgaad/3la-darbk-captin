import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/style/app_color.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../notifications/presentation/manager/notifications_cubit/cubit.dart';
import '../../../notifications/presentation/manager/notifications_cubit/state.dart';
import '../../../notifications/presentation/pages/notifications_view.dart';
import '../../../orders/presentation/pages/active_orders_view.dart';
import '../../../profile/presentation/manager/profile_cubit/cubit.dart';
import '../../../profile/presentation/manager/profile_cubit/state.dart';
import '../../../profile/presentation/pages/profile_view.dart';
import '../../../profits/presentation/pages/profits_view.dart';
import '../../../trips/presentation/manager/trips/cubit.dart';
import '../../../trips/presentation/pages/active_trips_view.dart';
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
                      ? state.index==3 ?null:FloatingActionButton(
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
                    const BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(Icons.person),
                      ),
                      label: AppStrings.myAccount,
                    ),
                    const BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(Icons.shopping_cart),
                      ),
                      label: AppStrings.orders,
                    ),
                    const BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(FontAwesomeIcons.road),
                      ),
                      label: AppStrings.trips,
                    ),
                    const BottomNavigationBarItem(
                      icon: Padding(
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
                            return state.notifications.where((e)=>e.isRead==0).length;
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
