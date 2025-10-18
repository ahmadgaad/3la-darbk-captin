import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ala_darbk_catain_app.dart';
import 'core/bloc_observe.dart';
import 'core/config/style/app_status_bar.dart';
import 'core/db_injection.dart';

Future<Locale> _getCachedLocale() async {
  const String languageKey = 'selected_language';
  const String defaultLanguage = 'ar';

  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString(languageKey) ?? defaultLanguage;
  return Locale(savedLanguage);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await DpInjection.init();
  AppStatusBar.setStatusBarStyle();

  // Get cached locale
  final cachedLocale = await _getCachedLocale();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      EasyLocalization(
        startLocale: cachedLocale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: const AlaDarbkCaptainApp(),
      ),
    ),
  );
}
