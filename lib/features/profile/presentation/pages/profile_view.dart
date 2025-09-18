import 'package:ala_darbak_captain/features/orders/presentation/manager/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/style/app_color.dart';
 import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../setttings_info/presentation/manager/cubit.dart';
import '../../../trips/presentation/manager/trips/cubit.dart';
import '../manager/profile_cubit/cubit.dart';
import '../widgets/avaliability.dart';
import '../widgets/profile_details.dart';
import '../widgets/delete_account_dialog.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userVerfied = context.watch<ProfileCubit>().state.currentUser?.status != 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.profile),
      ),
      body: RefreshIndicator(
        onRefresh: () async{ 
          return await context.read<ProfileCubit>().getProfile();
         },
        child: ListView(
          padding: EdgeInsets.only(top: 20.h, bottom: 80),
          children: [
            const ProfileDetails(),
            20.verticalSpace,
            if(userVerfied)
            const Avaliability(),
            10.verticalSpace,
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.editProfileScreen);
              },
              leading: const Icon(Icons.person_pin_rounded),
              title: const Text(AppStrings.profile2),
            ),
             ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.editCarScreen);
              },
              leading: const Icon(FontAwesomeIcons.carRear),
              title: const Text(AppStrings.myCar),
            ),
            if(userVerfied)...{
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.tripsHistory, arguments: context.read<TripsCubit>());
              },
              leading: const Icon(Icons.history),
              title: const Text(AppStrings.tripHistory),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.ordersHistory,arguments: context.read<OrdersCubit>());
              },
              leading: const Icon(Icons.history),
              title: const Text(AppStrings.ordersHistory),
            ),},
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.changePassword);
              },
              leading: const Icon(Icons.lock_outline),
              title: const Text(AppStrings.changePassword),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.termsAndConditions);
              },
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text(AppStrings.termsAndConditions),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.policy);
              },
              leading: const Icon(Icons.policy_outlined),
              title: const Text(AppStrings.privacy),
            ),
            ListTile(
            onTap: () async {
              final url =
                  "tel:${context.read<SettingsInfoCubit>().state.settingsInfo?.callUs ?? "0"}";
              if (await launchUrl(Uri.parse(url))) {}
            },
            leading: const Icon(Icons.support_agent),
            title: const Text(AppStrings.callSupport),
          ),
            ListTile(
              onTap: () {
                context.read<ProfileCubit>().logout();
              },
              leading: const Icon(Icons.logout),
              title: const Text(AppStrings.logout),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteAccountDialog();
                  },
                );
              },
              leading: const Icon(
                Icons.delete_forever_outlined,
                color: AppColors.red,
              ),
              title: const Text(
                AppStrings.deleteAccount,
                style: TextStyle(color: AppColors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
