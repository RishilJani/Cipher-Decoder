import 'package:cipher_decoder/utils/import_export.dart';

class DashboardEncodeDecode extends StatefulWidget {
  const DashboardEncodeDecode({super.key});

  @override
  State<DashboardEncodeDecode> createState() => _DashboardEncodeDecodeState();
}

class _DashboardEncodeDecodeState extends State<DashboardEncodeDecode>
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
          title: 'ENCODE / DECODE',
          content: '> DATA TRANSFORMATION TERMINAL',
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
              EncodeView(),
               DecodeView(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildEnhancedTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
              text: "ENCODE",
            ),
            Tab(
              text: "DECODE",
            ),
          ],
        ),
      ),
    );
  }
}
