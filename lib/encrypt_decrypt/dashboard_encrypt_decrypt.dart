import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class DashboardEncryptDecrypt extends StatefulWidget {
  const DashboardEncryptDecrypt({super.key});

  @override
  State<DashboardEncryptDecrypt> createState() => _DashboardEncryptDecryptState();
}

class _DashboardEncryptDecryptState extends State<DashboardEncryptDecrypt>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: cyberpunkDark,
        appBar: _buildEnhancedAppBar(),
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
          child: TabBarView(
            controller: _tabController,
            children: [
              EncryptionView(),
              DecryptionView(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar() {
    return AppBar(
      title: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [cyberpunkGreen, cyberpunkCyan],
            ).createShader(bounds),
            child: const Text(
              'ENCRYPT / DECRYPT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'monospace',
                letterSpacing: 2.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: cyberpunkGreen.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: cyberpunkGreen.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: const Text(
              '> CRYPTOGRAPHIC OPERATIONS TERMINAL',
              style: TextStyle(
                fontSize: 9,
                color: cyberpunkGreen,
                fontFamily: 'monospace',
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: cyberpunkDark,
      elevation: 0,
      toolbarHeight: 75,

      // leading: Container(
      //   height: 100,
      //   margin: const EdgeInsets.all(8),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     gradient: LinearGradient(
      //       colors: [
      //         cyberpunkCyan.withOpacity(0.2),
      //         cyberpunkCyan.withOpacity(0.1),
      //       ],
      //     ),
      //     border: Border.all(
      //       color: cyberpunkCyan.withOpacity(0.4),
      //       width: 1,
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: cyberpunkCyan.withOpacity(0.2),
      //         blurRadius: 8,
      //         spreadRadius: 1,
      //         offset: const Offset(0, 2),
      //       ),
      //     ],
      //   ),
      //   child: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: cyberpunkCyan, size: 20),
      //     onPressed: () => Get.back(),
      //     tooltip: "RETURN TO DASHBOARD",
      //   ),
      // ),

      bottom: _buildEnhancedTabBar(),
    );
  }

  PreferredSizeWidget _buildEnhancedTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cyberpunkPurple.withOpacity(0.1),
              cyberpunkCyan.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cyberpunkPurple.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkGreen.withOpacity(0.3),
                cyberpunkCyan.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkGreen.withOpacity(0.4),
              width: 1,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: cyberpunkGreen,
          unselectedLabelColor: cyberpunkCyan.withOpacity(0.7),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            letterSpacing: 1.0,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
            letterSpacing: 1.0,
          ),
          tabs: const [
            Tab(
              // icon: Icon(Icons.lock, size: 20),
              text: "ENCRYPTION",
            ),
            Tab(
              // icon: Icon(Icons.lock_open, size: 20),
              text: "DECRYPTION",
            ),
          ],
        ),
      ),
    );
  }
}
