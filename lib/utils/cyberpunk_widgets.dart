import 'package:cipher_decoder/utils/import_export.dart';

// Cyberpunk Method Option Button that integrates with your existing system
class CyberpunkMethodButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CyberpunkMethodButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CyberpunkMethodButton> createState() => _CyberpunkMethodButtonState();
}

class _CyberpunkMethodButtonState extends State<CyberpunkMethodButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.isSelected) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(CyberpunkMethodButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: widget.isSelected
                  ? LinearGradient(
                colors: [
                  const Color(0xFF00FF41).withOpacity(0.3 * _pulseAnimation.value),
                  const Color(0xFF00FFFF).withOpacity(0.2 * _pulseAnimation.value),
                ],
              )
                  : LinearGradient(
                colors: [
                  const Color(0xFF00FFFF).withOpacity(0.1),
                  const Color(0xFF9D00FF).withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: widget.isSelected
                    ? const Color(0xFF00FF41).withOpacity(_pulseAnimation.value)
                    : const Color(0xFF00FFFF),
                width: widget.isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: widget.isSelected
                  ? [
                BoxShadow(
                  color: const Color(0xFF00FF41).withOpacity(0.4 * _pulseAnimation.value),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
                  : null,
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: widget.isSelected
                      ? const Color(0xFF00FF41)
                      : const Color(0xFF00FFFF),
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}

// Extension to modify your existing option controllers to use cyberpunk styling
extension CyberpunkMethodOptions on EncryptionDecryptionOptionsController {
  Widget getCyberpunkOptionList({required controller , selectedIndex}) {
    return Obx(() {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: encryptionDecryptionMethods.asMap().entries.map((entry) {
          int index = entry.key;
          var method = entry.value;
          String methodName = '';

          // Map your existing method types to display names
          if (method is CeaseCipher) {
            methodName = 'CAESAR';
          } else if (method is AtbashCipher) {
            methodName = 'ATBASH';
          } else if (method is MonoAlphabaticCipher) {
            methodName = 'MONO-ALPHA';
          } else if (method is RailFenceCipher) {
            methodName = 'RAIL FENCE';
          } else {
            methodName = method.runtimeType.toString().toUpperCase();
          }

          return CyberpunkMethodButton(
            text: methodName,
            isSelected: selectedIndex.value == index,
            onPressed: () {
              selectedIndex.value = index;
              onChange(controller: controller);
            },
          );
        }).toList(),
      );
    });
  }
}

extension CyberpunkEncodeDecodeOptions on EncodeDecodeOptionController {
  Widget getCyberpunkOptionList({required controller, selectedIndex}) {
    return Obx(() {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: encodeDecodeMethods.asMap().entries.map((entry) {
          int index = entry.key;
          var method = entry.value;
          String methodName = '';

          // Map your existing encode/decode types to display names
          if (method is Base64) {
            methodName = 'BASE64';
          } else if (method is Base32) {
            methodName = 'BASE32';
          } else {
            methodName = method.runtimeType.toString().toUpperCase();
          }

          return CyberpunkMethodButton(
            text: methodName,
            isSelected: selectedIndex.value == index,
            onPressed: () {
              selectedIndex.value = index;
              onChange(controller: controller);
            },
          );
        }).toList(),
      );
    });
  }
}

// Update the pasteIconButton and clearIconButton to use cyberpunk styling
Widget cyberpunkPasteIconButton({required controller, required Function onChange}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF9D00FF), width: 1),
      borderRadius: BorderRadius.circular(4),
      gradient: LinearGradient(
        colors: [
          const Color(0xFF9D00FF).withOpacity(0.1),
          const Color(0xFF9D00FF).withOpacity(0.05),
        ],
      ),
    ),
    child: IconButton(
      icon: const Icon(Icons.paste, color: Color(0xFF9D00FF), size: 18),
      onPressed: () async {
        // Add your paste functionality here
        // ClipboardData? data = await Clipboard.getData('text/plain');
        // if (data != null) {
        //   controller.plainTextController.text = data.text ?? '';
        //   onChange(controller: controller);
        // }
      },
      tooltip: 'PASTE DATA',
      constraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),
    ),
  );
}

Widget cyberpunkClearIconButton({
  required controller,
  required encryptionDecryptionOptionsController,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFFF0040), width: 1),
      borderRadius: BorderRadius.circular(4),
      gradient: LinearGradient(
        colors: [
          const Color(0xFFFF0040).withOpacity(0.1),
          const Color(0xFFFF0040).withOpacity(0.05),
        ],
      ),
    ),
    child: IconButton(
      icon: const Icon(Icons.clear, color: Color(0xFFFF0040), size: 18),
      onPressed: () {
        controller.plainTextController.clear();
        controller.cipherTextController.clear();
        encryptionDecryptionOptionsController.onChange(controller: controller);
      },
      tooltip: 'CLEAR ALL DATA',
      constraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),
    ),
  );
}