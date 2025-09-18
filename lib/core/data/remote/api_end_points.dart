class ApiEndPoints {
  static const String register = 'driver/register';
  static const String login = 'driver/login';
  static const String sendCode = 'driver/send-code';
  static const String commission = 'driver/getCommission';
  static const String payCommission = 'driver/update_paidcommission';
  static const String withDrawProfits = 'driver/update_withdrawprofit';
  static const String checkUserExists = 'driver/check-user-exists';
  static const String changePassword = 'driver/change-password';
  static const String forgetPassword = 'driver/forget-password';
  static const String logout = 'driver/logout';
  static const String getNotifications = 'driver/notifications';
  static const String readNotification = 'driver/read-notification';
  static const String updateFcmToken = 'driver/update-device-token';
  static const String driverData = 'driver';
  static const String updateDriver = 'driver/update';
  static const String available = 'driver/available';
  static const String getCategories = 'categories';
  static const String orders = 'driver/orders';
  static const String assignOrder = 'driver/orders/assign';
  static const String payOrder = 'driver/orders/pay';
  static const String updateOrder = 'driver/orders/update';
  static const String activeOrders = 'driver/orders/active';
  static const String trips = 'driver/trips';
  static const String tripUpdate = 'driver/trips/update';
  static const String activeTrips = 'driver/trips/active';
  static String tripOrders(int tripId) => 'driver/trips/$tripId/orders';
static const String settingsInfo = 'setting-info';


  static const String cities = 'cities';
}
