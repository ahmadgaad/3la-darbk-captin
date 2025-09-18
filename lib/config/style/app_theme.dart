import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';
import 'app_text_styles.dart';

ThemeData get appTheme => ThemeData(
  badgeTheme: const BadgeThemeData(backgroundColor: AppColors.secondary),
    useMaterial3: true,
    fontFamily: "cairo",
    iconTheme: const IconThemeData(color: AppColors.secondary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.desSelected,
      selectedIconTheme: const IconThemeData(color: AppColors.primary, size: 28),
      unselectedIconTheme:
          const IconThemeData(color: AppColors.desSelected, size: 28),
      selectedLabelStyle: AppTextStyle.font14primary600,
      unselectedLabelStyle: AppTextStyle.font14desSelected500,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyle.font16black600,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: AppColors.backGround,
    listTileTheme: ListTileThemeData(
        iconColor: AppColors.secondary,
        titleTextStyle: AppTextStyle.font16black500),
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.primary,
      suffixIconColor: AppColors.secondary,
      hintStyle: AppTextStyle.font16desSelected500,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      errorMaxLines: 2,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 50.h),
            textStyle: AppTextStyle.font16white500,
            foregroundColor: AppColors.white,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
                
    tabBarTheme: TabBarThemeData(
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppTextStyle.font16primary600,
      unselectedLabelStyle: AppTextStyle.font16desSelected500,
    ),
    colorScheme: const ColorScheme.light(
        secondary: AppColors.secondary,
        primary: AppColors.primary,
        surface: AppColors.backGround));

ThemeData get profitTheme => ThemeData(
    useMaterial3: true,
    fontFamily: "cairo",
    iconTheme: const IconThemeData(color: AppColors.secondary),
    listTileTheme: ListTileThemeData(
        iconColor: AppColors.secondary,
        titleTextStyle: AppTextStyle.font16black500),
    drawerTheme: const DrawerThemeData(
        shape: RoundedRectangleBorder(), backgroundColor: AppColors.backGround),
    appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyle.font16black600,
        titleSpacing: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark)),
    tabBarTheme: TabBarThemeData(
      dividerColor: AppColors.desSelected,
      dividerHeight: 1,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        color: AppColors.primary,
      ),
      labelStyle: AppTextStyle.font14white600,
      unselectedLabelStyle: AppTextStyle.font14desSelected600,
    ),
    scaffoldBackgroundColor: AppColors.backGround,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: AppTextStyle.font16white500,
          foregroundColor: AppColors.white,
          fixedSize: Size.fromHeight(50.h),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.secondary,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.primary),
      textStyle: AppTextStyle.font14black600,
    )),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.primary,
      hintStyle: AppTextStyle.font16desSelected500,
      suffixIconColor: AppColors.secondary,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary)),
      contentPadding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    ),
    colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.backGround));
