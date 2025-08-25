import 'package:cipher_decoder/utils/import_export.dart';
import 'dart:math' as math;
class MyBackgroundAnimation extends StatefulWidget {
  const MyBackgroundAnimation({super.key});

  @override
  State<MyBackgroundAnimation> createState() => _MyBackgroundAnimationState();
}

class _MyBackgroundAnimationState extends State<MyBackgroundAnimation> with TickerProviderStateMixin{
  late AnimationController _matrixController;
  final List<MatrixChar> _matrixChars = [];

  @override
  void initState() {
    super.initState();
    _matrixController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _generateMatrixChars();
  }

  void _generateMatrixChars() {
    const chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _matrixChars.add(MatrixChar(
        char: chars[random.nextInt(chars.length)],
        x: random.nextDouble(),
        speed: 0.3 + random.nextDouble() * 1.5,
        delay: random.nextDouble() * 5,

      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _matrixController,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: MatrixPainter(_matrixChars, _matrixController.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _matrixController.dispose();
    super.dispose();
  }
}


// to copy text into clipboard
void copyText(String txt) {
  Clipboard.setData(ClipboardData(text: txt)).then(
        (value) {
      Get.snackbar("Success", "Cipher text copied successfully",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM);
    },
  );
}

// to paste text from clipboard
void pasteText({controller, required Function onChange}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {

    if (controller is EncodeController || controller is EncryptionController) {
      controller.plainTextController.text = data.text!;
    }
    else if (controller is DecodeController || controller is DecryptionController) {
      controller.cipherTextController.text = data.text!;
    }else{
      throw ControllerTypeException(message: "Controller is not right in pasteText ${controller.runtimeType}");
    }
    onChange(controller: controller);
  }
}

// paste Icon button
Widget pasteIconButton({controller, onChange}) {
  return IconButton(
      onPressed: () {
        pasteText(controller: controller, onChange: onChange);
      },
      icon: const Icon(Icons.paste)
  );
}

// clear Icon button
Widget clearIconButton(
    {controller, required encryptionDecryptionOptionsController}) {
  return IconButton(
    onPressed: () {
      controller!.plainTextController.clear();
      controller!.cipherTextController.clear();
      if (encryptionDecryptionOptionsController != null) {
        encryptionDecryptionOptionsController.desc.value = '';
      }
    },
    icon: const Icon(Icons.clear, color: cyberpunkRed, size: 32),
    tooltip: "Clear",
  );
}


void showSnackBar(){
  Get.snackbar("Max Limit Reached", "Can't add more methods",
      duration: const Duration(seconds: 5),
      backgroundColor: cyberpunkDarkElevated,
      colorText: cyberpunkGreen,
      snackPosition: SnackPosition.BOTTOM
  );
}