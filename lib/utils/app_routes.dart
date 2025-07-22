import 'package:cipher_decoder/utils/import_export.dart';

class AppRoutes{
  AppRoutes._();
  static String initial = RT_DASHBOARD;

  static List<GetPage> routes = [
    GetPage(
        name: RT_DASHBOARD,
        page: ()=> const Dashboard()
    ),

    GetPage(
      name:RT_ENCODING_VIEW,
      page: () => const EncodingView(),
    ),

    GetPage(
        name: RT_DECODING_VIEW,
        page: () => const DecodingView()
    )
  ];
}