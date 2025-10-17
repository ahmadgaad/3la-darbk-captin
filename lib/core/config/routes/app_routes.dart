import 'package:ala_darbak_captain/features/setttings_info/presentation/pages/terms_condtions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../db_injection.dart';
import '../../../features/auth/presentation/pages/auth_screen.dart';
import '../../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../../features/layout/presentation/manager/cubit.dart';
import '../../../features/notifications/presentation/manager/notifications_cubit/cubit.dart';
import '../../../features/orders/presentation/manager/cubit.dart';
import '../../../features/orders/presentation/pages/history_orders_screen.dart';
import '../../../features/profile/presentation/pages/change_password_screen.dart';
import '../../../features/profile/presentation/pages/edit_car_screen.dart';
import '../../../features/profile/presentation/pages/edit_profile_screen.dart';
import '../../../features/profits/manager/cubit.dart';
import '../../../features/setttings_info/presentation/pages/policy_screen.dart';
import '../../../features/trips/presentation/manager/trips/cubit.dart';
import '../../../features/trips/presentation/pages/create_trip_screen.dart';
import '../../../features/layout/presentation/pages/layout_screen.dart';
import '../../../features/order/presentation/pages/order_details_screen.dart';
import '../../../features/trips/presentation/pages/trip_details_screen.dart';
import '../../../features/trips/presentation/pages/trips_histpry_screen.dart';

class AppRoute {
  static const String auth = "/auth";
  static const String editProfileScreen = "/editProfileScreen";
  static const String editCarScreen = "/editCarScreen";
  static const String termsAndConditions = "/termsAndConditions";
  static const String policy = "/policy";
  static const String changePassword = "/changePassword";
  static const String forgetPassword = "/forgetPassword";
  static const String layout = "/layout";
  static const String orderDetails = "/order_details";
  static const String ordersHistory = "/orders_history";
  static const String createTrip = "/create_trip";
  static const String tripDetails = "/trip_details";
  static const String tripsHistory = "/trips_history";

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      var args = settings.arguments;

      switch (settings.name) {
        case auth:
          return _animateRouteBuilder(const AuthScreen(), x: 0, y: 1);
        case forgetPassword:
          return _animateRouteBuilder(const ForgetPasswordScreen(), x: 0, y: 1);
        case layout:
          return _animateRouteBuilder(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => LayoutCubit(context)),
                BlocProvider(
                  create:
                      (context) =>
                          OrdersCubit(sl())
                            ,
                ),
                BlocProvider(
                  create:
                      (context) =>
                          TripsCubit(sl())
                            ,
                ),
                BlocProvider(create: (context) => NotificationsCubit(sl())),
                BlocProvider(create: (context) => CommissionCubit(sl())),
              ],
              child: const LayoutScreen(),
            ),
            x: 0,
            y: 1,
          );
        case orderDetails:
          return _animateRouteBuilder(
            OrderDetailsScreen(id: args as int),
            x: -1,
            y: 0,
          );
        case createTrip:
          return _animateRouteBuilder(const CreateTripScreen(), x: -1, y: 0);
        case editProfileScreen:
          return _animateRouteBuilder(const EditProfileScreen(), x: -1, y: 0);
        case editCarScreen:
          return _animateRouteBuilder(const EditCarScreen(), x: -1, y: 0);
        case changePassword:
          return _animateRouteBuilder(
            const ChangePasswordScreen(),
            x: -1,
            y: 0,
          );
        case termsAndConditions:
          return _animateRouteBuilder(
            const TermsCondtionsScreen(),
            x: -1,
            y: 0,
          );
        case policy:
          return _animateRouteBuilder(const PolicyScreen(), x: -1, y: 0);
        case tripDetails:
          if (args == null) return _errorRoute();
          return _animateRouteBuilder(
            BlocProvider.value(
              value: (args as List)[0] as TripsCubit,
              child: TripDetailsScreen(tripId: (args)[1]),
            ),
            x: -1,
            y: 0,
          );
        case tripsHistory:
          if (args == null) return _errorRoute();
          return _animateRouteBuilder(
            BlocProvider.value(
              value: args as TripsCubit,
              child: const TripsHistoryScreen(),
            ),
            x: -1,
            y: 0,
          );
        case ordersHistory:
          return _animateRouteBuilder(
            BlocProvider.value(
              value: args as OrdersCubit,
              child: const HistoryOrdersScreen(),
            ),
            x: -1,
            y: 0,
          );
        default:
          return MaterialPageRoute(builder: (_) => const AuthScreen());
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static Future pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) async {
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future pushNamed(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static pop<T>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  static bool get canPop => navigatorKey.currentState?.canPop() ?? false;

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('خطأ')),
          body: const Center(
            child: Text('نعتذر حدث خطأ , الرجاء اعادة المحاولة'),
          ),
        );
      },
    );
  }

  static _animateRouteBuilder(Widget to, {double x = 1, double y = 0}) =>
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => to,
        opaque: false,
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, animation, animationTime, child) {
          final tween = Tween<Offset>(
            begin: Offset(x, y),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));
          final tween2 = Tween<double>(begin: 0, end: 1);
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation.drive(tween2),
              child: child,
            ),
          );
        },
      );
}
