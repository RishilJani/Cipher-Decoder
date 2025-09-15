import 'package:cipher_decoder/utils/import_export.dart';

class AppRoutes {
  static String InitialRoute = RT_SPLASH_SCREEN;
  static var pages = [
    GetPage(name: RT_SPLASH_SCREEN, page: () => MySplashScreen()),
    GetPage(name: RT_FEEDBACK_SCREEN, page: () => FeedbackScreen(),transition: Transition.fade),
    GetPage(name: RT_ABOUT_US_SCREEN, page: () => AboutUs(),transition: Transition.fade),

    GetPage(name: RT_MAIN_SCREEN, page: () => const MainNavigationScreen()),

    GetPage(name: RT_DASHBOARD, page: () => const Dashboard(),),
    GetPage(name: RT_DASHBOARD_ENCODE_DECODE, page: () => const DashboardEncodeDecode(),),
    GetPage(name: RT_DASHBOARD_ENCRYPT_DECRYPT,  page: () => const DashboardEncryptDecrypt(),),
  ];
}
