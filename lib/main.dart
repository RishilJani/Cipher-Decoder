import 'package:cipher_decoder/utils/colors.dart';
import 'package:cipher_decoder/utils/import_export.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final Color backgroundColor = const Color(0xFFE0F7FA);
  // final Color surfaceColor = const Color(0xFFD6E4E5);
  // final Color primaryColor = const Color(0xFFBCCCDC);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch:  MaterialColor(darkPrimary.value,const <int,Color>{
            50 : darkPrimary,
            100 : darkPrimary,
            200 : darkPrimary,
            300 : darkPrimary,
            400 : darkPrimary,
            500 : darkPrimary,
            600 : darkPrimary,
            700 : darkPrimary,
            800 : darkPrimary,
            900 : darkPrimary,
          }),
          accentColor: darkAccent,
          brightness: Brightness.dark
        ).copyWith(
          primary: darkPrimary,
          onPrimary: darkSurface,
          secondary: darkAccent,
          onSecondary: darkSurface,
          surface: darkSurface,
          onSurface: darkOnSurface,
          error: darkError,
          onError: darkOnSurface,
        ),

        scaffoldBackgroundColor: darkSurface,
        cardColor: darkElevatedSurface,
        dialogBackgroundColor: darkElevatedSurface,
        canvasColor: darkSurface,

        iconTheme: const IconThemeData(color: darkOnSurface),

        textTheme: const TextTheme(
          displayLarge: TextStyle(color: darkOnSurface),
          displayMedium: TextStyle(color: darkOnSurface),
          displaySmall: TextStyle(color: darkOnSurface),
          headlineLarge: TextStyle(color: darkOnSurface),
          headlineMedium: TextStyle(color: darkOnSurface),
          headlineSmall: TextStyle(color: darkOnSurface),
          titleLarge: TextStyle(color: darkOnSurface),
          titleMedium: TextStyle(color: darkOnSurface),
          titleSmall: TextStyle(color: darkOnSurface),
          bodyLarge: TextStyle(color: darkOnSurface),
          bodyMedium: TextStyle(color: darkOnSurface),
          bodySmall: TextStyle(color: darkOnSurface),
          labelLarge: TextStyle(color: darkOnSurface),
          labelMedium: TextStyle(color: darkOnSurface),
          labelSmall: TextStyle(color: darkOnSurface),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: darkElevatedSurface,
          foregroundColor: darkOnSurface,
          titleTextStyle: TextStyle(
            color: darkOnSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          iconTheme: IconThemeData(color: darkOnSurface)
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPrimary,
            foregroundColor: darkSurface
          )
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: darkPrimary,
          foregroundColor: darkSurface
        )
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
/*
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
 */

/*
#162139
#324260
#526486
#798fb6
#a5badd
 */