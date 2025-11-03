import 'package:ala_darbak_captain/features/setttings_info/presentation/manager/cubit.dart';
import 'package:alice/alice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'core/config/routes/app_routes.dart';
import 'core/config/style/app_color.dart';
import 'core/config/style/app_theme.dart';
import 'core/db_injection.dart';
import 'core/screens/splash_screen.dart';
import 'features/profile/presentation/view_model/profile_cubit/cubit.dart';
import 'features/profile/presentation/view_model/profile_cubit/state.dart';
import 'features/trips/presentation/view_model/cities/cubit.dart';

class AlaDarbkCaptainApp extends StatelessWidget {
  const AlaDarbkCaptainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:
          (_, child) => OKToast(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileCubit(sl()),
                  lazy: false,
                ),
                BlocProvider(
                  create: (context) => CitiesCubit(sl())..getCities(),
                  lazy: false,
                ),
                BlocProvider(
                  create:
                      (context) => SettingsInfoCubit(sl())..getSettingInfo(),
                  lazy: false,
                ),
              ],
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, profileState) {
                  return MaterialApp(
                    title: 'علي دربك كابتن',
                    debugShowCheckedModeBanner: false,
                    theme: appTheme,
                    themeMode: ThemeMode.light,
                    color: AppColors.backGround,
                    home: const SplashScreen(),
                    navigatorKey: AppRoute.navigatorKey,
                    // navigatorKey: sl<Alice>().getNavigatorKey(),
                    onGenerateRoute: AppRoute.generateRoute,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: profileState.currentLocale,
                  );
                },
              ),
            ),
          ),
    );
  }
}
