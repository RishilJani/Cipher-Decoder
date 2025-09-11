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
          color: cyberpunkDarkElevated,
          elevation: 8,
          shadowColor: cyberpunkGreen.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cyberpunkDarkElevated,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cyberpunkCyan.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cyberpunkCyan.withOpacity(0.3)),
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
            shadowColor: cyberpunkGreen.withOpacity(0.4),
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
      initialRoute: RT_SPLASH_SCREEN,
      getPages: [
        GetPage(name: RT_SPLASH_SCREEN, page: () => SplashScreen()),
        GetPage(name: RT_FEEDBACK_SCREEN, page: () => FeedbackScreen()),
        GetPage(name: RT_MAIN_SCREEN, page: () => const MainNavigationScreen()),
        GetPage(name: RT_DASHBOARD_ENCODE_DECODE,  page: () => const DashboardEncodeDecode(),),
        GetPage(name: RT_DASHBOARD_ENCRYPT_DECRYPT,  page: () => const DashboardEncryptDecrypt(), ),
      ],
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  static const double _headerHeight = 150;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging &&
          _currentIndex != _tabController.index) {
        setState(() => _currentIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cyberpunkDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cyberpunkDark,
              cyberpunkDarkElevated,
              Color(0xFF16213E),
            ],
          ),
        ),
        child: Column(
          children: [
            // Enhanced Header
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              child: SizedBox(
                height: _currentIndex == 0 ? _headerHeight : 0,
                child: RepaintBoundary(child: _buildEnhancedHeader()),
              ),
            ),

            // Main Content Area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDashboardTab(),
                  _buildEncodeDecodeTab(),
                  _buildEncryptDecryptTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildEnhancedHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: Column(
        children: [
          // Main Title with Glow Effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cyberpunkGreen.withOpacity(0.15),
                  cyberpunkCyan.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: cyberpunkGreen.withOpacity(0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: cyberpunkGreen.withOpacity(0.3),
                  blurRadius: 24,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [cyberpunkGreen, cyberpunkCyan],
              ).createShader(bounds),
              child: const Text(
                APPLICATION_NAME,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'monospace',
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // // Status Indicator
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: 10,
          //       height: 10,
          //       decoration: BoxDecoration(
          //         color: cyberpunkGreen,
          //         borderRadius: BorderRadius.circular(5),
          //         boxShadow: [
          //           BoxShadow(
          //             color: cyberpunkGreen.withOpacity(0.6),
          //             blurRadius: 12,
          //             spreadRadius: 2,
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Container(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //       decoration: BoxDecoration(
          //         color: cyberpunkGreen.withOpacity(0.2),
          //         borderRadius: BorderRadius.circular(16),
          //         border: Border.all(
          //           color: cyberpunkGreen.withOpacity(0.4),
          //           width: 1,
          //         ),
          //       ),
          //       child: const Text(
          //         'SYSTEM ONLINE',
          //         style: TextStyle(
          //           fontSize: 12,
          //           color: cyberpunkGreen,
          //           fontFamily: 'monospace',
          //           fontWeight: FontWeight.w700,
          //           letterSpacing: 1.2,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return const Dashboard();
  }

  Widget _buildEncodeDecodeTab() {
    return const DashboardEncodeDecode();
  }

  Widget _buildEncryptDecryptTab() {
    return const DashboardEncryptDecrypt();
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: cyberpunkDarkElevated,
        border: Border(
          top: BorderSide(
            color: cyberpunkGreen.withOpacity(0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.dashboard, 'Dashboard'),
              _buildNavItem(1, Icons.transform, 'Encode/Decode'),
              _buildNavItem(2, Icons.lock, 'Encrypt/Decrypt'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        _tabController.animateTo(
          index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? cyberpunkGreen.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? cyberpunkGreen.withOpacity(0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? cyberpunkGreen : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? cyberpunkGreen : Colors.grey[400],
                fontFamily: 'monospace',
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
