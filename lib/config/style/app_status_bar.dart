import 'package:flutter/services.dart';

import 'app_color.dart';

class AppStatusBar {
  static hide() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  static show() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  static setStatusBarStyle(
          {Color? statusBarColor, Brightness? statusBarIconBrightness}) =>
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
          statusBarColor: statusBarColor ?? AppColors.white));
}
