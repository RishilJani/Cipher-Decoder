import 'package:cipher_decoder/encrypt_decrypt/dashboard_encrypt_decrypt.dart';
import 'package:cipher_decoder/utils/import_export.dart';

class AppRoutes{
  AppRoutes._();
  static String initial = RT_DASHBOARD_ENCRYPT_DECRYPT;

  static List<GetPage> routes = [
    GetPage(
        name: RT_DASHBOARD_ENCRYPT_DECRYPT,
        page: () => DashboardEncryptDecrypt()
    ),

    GetPage(
        name: RT_DASHBOARD,
        page: ()=> const Dashboard()
    ),

    GetPage(
      name:RT_ENCRYPTION_VIEW,
      page: () => EncryptionView(),
    ),

    GetPage(
        name: RT_DECRYPTION_VIEW,
        page: () => DecryptionView()
    )
  ];
}