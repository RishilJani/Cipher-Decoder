import 'package:cipher_decoder/utils/import_export.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final Color backgroundColor = const Color(0xFFE0F7FA);
  final Color surfaceColor = const Color(0xFFD6E4E5);
  final Color primaryColor = const Color(0xFFBCCCDC);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,

        appBarTheme: AppBarTheme(
          backgroundColor: surfaceColor,
          foregroundColor: Colors.black,
        ),
        cardColor: surfaceColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          surface: surfaceColor,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Colors.black, fontSize: 20,),
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 17),
        ),
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}

/*
#162139
#324260
#526486
#798fb6
#a5badd
 */