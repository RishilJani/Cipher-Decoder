import 'package:cipher_decoder/utils/import_export.dart';

void main() {
  runApp(const CipherDecoderApp());
}

class CipherDecoderApp extends StatelessWidget {
  const CipherDecoderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cipher Decoder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cyberpunkGreen,
          primary: cyberpunkGreen,
          onPrimary: cyberpunkDark,
          secondary: cyberpunkCyan,
          onSecondary: cyberpunkDark,
          tertiary: cyberpunkPurple,
          onTertiary: cyberpunkDark,
          surface: cyberpunkDarkElevated,
          onSurface: Colors.white,
          error: cyberpunkRed,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: cyberpunkDark,
        canvasColor: cyberpunkDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
          iconTheme: IconThemeData(color: cyberpunkCyan),
        ),
        cardTheme: CardThemeData(
          color: cyberpunkGrayDark,
          elevation: 8,
          shadowColor: cyberpunkGreen.withValues(alpha : 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cyberpunkDarkElevated,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cyberpunkCyan.withValues(alpha: 0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cyberpunkCyan.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: cyberpunkCyan, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: cyberpunkRed),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'monospace',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: cyberpunkGreen,
            foregroundColor: cyberpunkDark,
            elevation: 4,
            shadowColor: cyberpunkGreen.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: cyberpunkCyan,
            textStyle: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: cyberpunkCyan,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFBDBDBD),
          ),
          labelLarge: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: cyberpunkCyan,
          ),
          labelMedium: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
            color: cyberpunkCyan,
          ),
          labelSmall: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
            color: cyberpunkCyan,
          ),
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: cyberpunkCyan,
          unselectedLabelColor: Colors.grey,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: cyberpunkCyan, width: 3),
            ),
          ),
          labelStyle: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialRoute: AppRoutes.InitialRoute,
      getPages: AppRoutes.pages,
    );
  }
}

