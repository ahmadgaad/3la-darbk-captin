import 'package:ala_darbak_captain/features/notifications/presentation/manager/notifications_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../manager/notifications_cubit/state.dart';
import '../widgets/notification_item.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().readNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(AppStrings.notifications)),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          // Handle loading state
          if (state.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  16.verticalSpace,
                  Text(AppStrings.loadingNotifications),
                ],
              ),
            );
          }

          // Handle error state
          if (state.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.errorLoadingNotifications,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () =>
                            context
                                .read<NotificationsCubit>()
                                .getNotifications(),
                    child: Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          // Handle empty state
          if (state.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.noNotifications,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Handle success state with data
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              return await context
                  .read<NotificationsCubit>()
                  .getNotifications();
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemBuilder:
                  (context, index) => NotificationItem(
                    notifications: state.notifications[index],
                  ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.notifications.length,
            ),
          );
        },
      ),
    );
  }
}
