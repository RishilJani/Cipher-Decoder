import 'package:cipher_decoder/utils/import_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  String displayText = "";
  final String appName = "SherlockCode";
  int textIndex = 0;

  @override
  void initState() {
    super.initState();

    // Logo fade + scale animation
    _logoController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    );
    _logoController.forward();

    // Start typewriter effect after logo appears
    Timer(const Duration(seconds: 3), () {
      _startTypingEffect();
    });

    // Navigate to home after 5s
    Timer(const Duration(seconds: 5), () {
      Get.offNamed(RT_MAIN_SCREEN);
    });
  }

  void _startTypingEffect() {
    Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (textIndex < appName.length) {
        setState(() {
          displayText += appName[textIndex];
          textIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            ScaleTransition(
              scale: _logoAnimation,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withValues(alpha : 0.8),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27.0), // Adjust the radius as needed
                  child: Image.asset(
                    "assets/image/SherlockCode.png", // put your logo here
                    height: 160,
                    
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Typewriter Text
            Text(
              displayText,
              style: GoogleFonts.robotoMono(
                textStyle: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
