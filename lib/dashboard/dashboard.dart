import 'package:cipher_decoder/utils/import_export.dart';
import 'dart:math' as math;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  // late AnimationController _matrixController;
  late AnimationController _glowController;
  // final List<MatrixChar> _matrixChars = [];

  @override
  void initState() {
    super.initState();
    // _matrixController = AnimationController(
    //   duration: const Duration(seconds: 20),
    //   vsync: this,
    // )..repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // _generateMatrixChars();
  }

  // void _generateMatrixChars() {
  //   const chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
  //   final random = math.Random();
  //   for (int i = 0; i < 30; i++) {
  //     _matrixChars.add(MatrixChar(
  //       char: chars[random.nextInt(chars.length)],
  //       x: random.nextDouble(),
  //       speed: 0.3 + random.nextDouble() * 1.5,
  //       delay: random.nextDouble() * 5,
  //
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cyberpunkPurple,
      appBar: _cyberpunkAppBar(title: APPBAR_TITLE_DASHBOARD, context: context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1A0B2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Matrix background animation
            const MyBackgroundAnimation(),
            /*
            // AnimatedBuilder(
            //   animation: _matrixController,
            //   builder: (context, child) {
            //     return CustomPaint(
            //       size: Size.infinite,
            //       painter: MatrixPainter(_matrixChars, _matrixController.value),
            //     );
            //   },
            // ), */


            // Main content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cyberpunk logo section
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _glowController,
                            builder: (context, child) {
                              return Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFF00FF41).withOpacity(0.3 * _glowController.value),
                                      const Color(0xFF00FFFF).withOpacity(0.1 * _glowController.value),
                                      Colors.transparent,
                                    ],
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF00FF41).withOpacity(0.5 + 0.5 * _glowController.value),
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.security,
                                  size: 60,
                                  color: Color(0xFF00FF41),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '> SYSTEM ONLINE\n> PROTOCOLS ACTIVE',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: Color(0xFF00FFFF),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Encode-Decode Button
                    _cyberpunkButton(
                      onPressed: () {
                        Get.toNamed(RT_DASHBOARD_ENCODE_DECODE);
                      },
                      child: const Text(
                        "ENCODE - DECODE",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF41),
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Encryption-Decryption Button
                    _cyberpunkButton(
                      onPressed: () {
                        Get.toNamed(RT_DASHBOARD_ENCRYPT_DECRYPT);
                      },
                      child: const Text(
                        "ENCRYPTION - DECRYPTION",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF41),
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // // Footer warning
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: const Color(0xFFFF0040).withOpacity(0.3),
                    //       width: 1,
                    //     ),
                    //     borderRadius: BorderRadius.circular(8),
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         const Color(0xFFFF0040).withOpacity(0.05),
                    //         Colors.transparent,
                    //       ],
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     '⚠ UNAUTHORIZED ACCESS DETECTED\n⚠ SECURITY PROTOCOLS ACTIVE',
                    //     style: TextStyle(
                    //       fontFamily: 'monospace',
                    //       fontSize: 10,
                    //       color: Color(0xFFFF0040),
                    //       height: 1.5,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cyberpunkButton({required VoidCallback onPressed, required Widget child}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 140,
            width: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF00FF41).withOpacity(0.01),
                  const Color(0xFF00FFFF).withOpacity(0.01),
                ],
              ),
              border: Border.all(
                color: const Color(0xFF00FF41),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FF41).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(child: child),
            ),
          ),
        );
      },
    );
  }

  AppBar _cyberpunkAppBar({String title = '', required context, bottom}) {
    return AppBar(
      title: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00FF41), Color(0xFF00FFFF)],
            ).createShader(bounds),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'monospace',
                letterSpacing: 2,
              ),
            ),
          ),
          const Text(
            'v2.1.0 - CLASSIFIED',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF00FFFF),
              fontFamily: 'monospace',
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      centerTitle: true,
      bottom: bottom,
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0A0A), Color(0xFF1A0B2E)],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
    // _matrixController.dispose();
  }
}

class MatrixChar {
  final String char;
  final double x;
  final double speed;
  final double delay;

  MatrixChar({
    required this.char,
    required this.x,
    required this.speed,
    required this.delay,
  });
}

class MatrixPainter extends CustomPainter {
  final List<MatrixChar> chars;
  final double animationValue;

  MatrixPainter(this.chars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    const textStyle = TextStyle(
      color: Color(0xFF00FF41),
      fontSize: 12,
      fontFamily: 'monospace',
    );

    for (final char in chars) {
      final y = ((animationValue * char.speed + char.delay) % 1) * (size.height + 100) - 50;
      if (y > -50 && y < size.height + 50) {
        final opacity = math.max(0.1, 1.0 - (y / size.height));
        final textPainter = TextPainter(
          text: TextSpan(
            text: char.char,
            style: textStyle.copyWith(
              color: textStyle.color!.withOpacity(opacity * 0.3),
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(char.x * size.width, y),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}