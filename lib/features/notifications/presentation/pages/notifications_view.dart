import 'package:ala_darbak_captain/features/notifications/presentation/manager/notifications_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../db_injection.dart';
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
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppStrings.notifications),
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async{ 
              return await context.read<NotificationsCubit>().getNotifications();
             },
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                itemBuilder: (context, index) => NotificationItem(
                      notifications: state.notifications[index],
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.notifications.length),
          );
        }));
  }
}
