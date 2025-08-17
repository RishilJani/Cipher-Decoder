import 'package:cipher_decoder/utils/import_export.dart';

class AppRoutes{
  AppRoutes._();
  static String initial = RT_DASHBOARD;

  static List<GetPage> routes = [
    GetPage( name: RT_DASHBOARD, page: () => const Dashboard() ),

    GetPage( name: RT_DASHBOARD_ENCRYPT_DECRYPT,  page: () => const DashboardEncryptDecrypt() ),
    GetPage( name:RT_ENCRYPTION_VIEW, page: () => EncryptionView(), ),
    GetPage( name: RT_DECRYPTION_VIEW,  page: () => DecryptionView() ),

    GetPage(name: RT_DASHBOARD_ENCODE_DECODE, page: () => const DashboardEncodeDecode()),
    GetPage( name: RT_ENCODING_VIEW ,  page: () => const EncodeView() ),
    GetPage(name: RT_DECODING_VIEW, page: () => const DecodeView())
  ];
}