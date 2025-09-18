import 'package:ala_darbak_captain/features/notifications/repositories/repositories.dart';
import 'package:ala_darbak_captain/features/setttings_info/repositories/repositories.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/app_config.dart';
import 'core/data/local/shared_preferences_service.dart';
import 'core/data/remote/api_client.dart';
import 'core/data/remote/interceptors/auth_interceptor.dart';
import 'features/auth/repositories/repositories.dart';
import 'features/order/repositories/repositories.dart';
import 'features/orders/repositories/repositories.dart';
import 'features/profile/repositories/repositories.dart';
import 'features/profits/data/repositories/repositories.dart';
import 'features/trips/repositories/repositories.dart';

final sl = GetIt.instance;

class DpInjection {
  static  init() async{

    ///Shared Preferences
   await _initSharedPref();

    ///Api Client
    _apiClientInit();

    ///Repositories
    _authRepoInit();
    _profileRepoInit();
    _ordersRepoInit();
    _orderRepoInit();
    _notificationsRepo();
    _settingsInfoRepo();
    _tripsRepoInit();
    _commissionRepoInit();
  }
static Future<void> _initSharedPref() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService (sharedPreferences: sharedPreferences),
  );
}
 
  static void _apiClientInit() {
       sl.registerSingleton<Dio>(Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      sendTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 60 * 1000),
    ),
  )..interceptors.addAll([
      AuthInterceptor(),
      LogInterceptor(
        request: false,
        responseHeader: false,
        error: false,
        requestBody: true,
        responseBody: true,
      ),
    ]));

  sl.registerSingleton<Logger>(Logger());

  sl.registerSingleton<ApiClient>(
    ApiClient(dio: sl(), logger: sl()),
  );
  }


  static _authRepoInit() {
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(),sl()));
  }
  
  static void _profileRepoInit() {
    sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl(),sl()));
  }
  static void _ordersRepoInit() {
    sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(sl()));
  }
  static void _orderRepoInit() {
    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  }
    static void _notificationsRepo() {
    sl.registerLazySingleton<NotificationsRepo>(() => NotificationsRepoImpl(sl()));
  }
    static void _settingsInfoRepo() {
    sl.registerLazySingleton<SettingsInfoRepository>(() => SettingsInfoRepositoryImpl(sl()));
  }
  
  static void _tripsRepoInit() {
    sl.registerLazySingleton<TripsRepository>(() => TripsRepositoryImpl(sl()));
  }
  
  static void _commissionRepoInit() {
    sl.registerLazySingleton<CommissionRepository>(() => CommissionRepositoryImpl(sl()));
  }
}
