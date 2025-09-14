import 'package:cipher_decoder/utils/import_export.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  var navigationController = Get.put(MainNavigationScreenController());
  static const double _headerHeight = 150;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging &&
          navigationController.selectedIndex.value != _tabController.index) {
        navigationController.changeIndex(_tabController.index);
      }
    });
  }

  late List<Widget> pages = [
    _buildDashboardTab(),
    _buildEncodeDecodeTab(),
    _buildEncryptDecryptTab(),
  ];
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
        child: Obx((){
              return Column(
                children: [
                  // Enhanced Header
                  AnimatedSize(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    child: SizedBox(
                      height: navigationController.selectedIndex.value == 0
                          ? _headerHeight
                          : 0,
                      child: RepaintBoundary(child: _buildEnhancedHeader()),
                    ),
                  ),

                  // Main Content Area
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: pages,
                    ),
                  ),
                ],
              );
            }
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
                  cyberpunkGreen.withValues(alpha: 0.15),
                  cyberpunkCyan.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: cyberpunkGreen.withValues(alpha: 0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: cyberpunkGreen.withValues(alpha: 0.3),
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
          //             color: cyberpunkGreen.withValues(0.6),
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
          //         color: cyberpunkGreen.withValues(0.2),
          //         borderRadius: BorderRadius.circular(16),
          //         border: Border.all(
          //           color: cyberpunkGreen.withValues(0.4),
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
            color: cyberpunkGreen.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx((){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(0, Icons.dashboard, 'Dashboard'),
                buildNavItem(1, Icons.transform, 'Encode/Decode'),
                buildNavItem(2, Icons.lock, 'Encrypt/Decrypt'),
              ],
            ),
          );
        }
        ),
      ),
    );
  }

  Widget buildNavItem(int index, IconData icon, String label) {
    final isSelected = navigationController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        navigationController.changeIndex(index);
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
          color: isSelected
              ? cyberpunkGreen.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? cyberpunkGreen.withValues(alpha: 0.5)
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
