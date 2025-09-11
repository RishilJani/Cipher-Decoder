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
        appBar: buildEnhancedAppBar(
          title: 'ENCRYPT / DECRYPT',
          content: '> CRYPTOGRAPHIC OPERATIONS TERMINAL',
          bottom: _buildEnhancedTabBar()
        ),
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

  PreferredSizeWidget _buildEnhancedTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cyberpunkPurple.withValues(alpha: 0.1),
              cyberpunkCyan.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cyberpunkPurple.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkGreen.withValues(alpha: 0.3),
                cyberpunkCyan.withValues(alpha: 0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkGreen.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: cyberpunkGreen,
          unselectedLabelColor: cyberpunkCyan.withValues(alpha: 0.7),
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

