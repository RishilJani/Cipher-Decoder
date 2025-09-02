import 'package:cipher_decoder/utils/import_export.dart';

Widget modernScreenLayout({
  required BuildContext context,
  required controller,
  required String titleText,
  required methodsController,
  bool? isEncoding = true,
  bool? isEncryption = true,
}) {
  return Scaffold(
    backgroundColor: cyberpunkDark,
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0A0A),
            Color(0xFF1A1A2E),
            cyberpunkDark,
            Color(0xFF16213E),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Close keyboard when tapping anywhere on screen
            FocusScope.of(context).unfocus();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Column(
            children: [
              // 🔄 MAIN CONTENT WITH RESPONSIVE CARDS
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      
                      // 🎯 INPUT CARD
                      _buildHorizontalInputCard(controller, context, titleText, methodsController, isEncoding!),
                      
                      const SizedBox(height: 20),
                      
                      // 🎯 METHODS CARD
                      _buildHorizontalMethodsCard(methodsController, controller),
                      
                      if (isEncryption!) ...[
                        const SizedBox(height: 20),
                        _buildHorizontalAddCard(controller, methodsController),
                      ],
                      
                      const SizedBox(height: 20),
                      
                      // 🎯 OUTPUT CARD
                      _buildHorizontalOutputCard(controller, context, methodsController, isEncoding),
                      
                      const SizedBox(height: 20),
                      
                      // 🎯 INFO CARD
                      _buildHorizontalInfoCard(methodsController),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// 🎯 TAB ITEM
// Widget _buildTabItem(String text, Color color, bool isActive) {
//   return Expanded(
//     child: Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: isActive ? color.withOpacity(0.2) : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isActive ? color.withOpacity(0.5) : color.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 11,
//           color: isActive ? color : color.withOpacity(0.7),
//           fontFamily: 'monospace',
//           fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
//         ),
//       ),
//     ),
//   );
// }

// 🎯 HORIZONTAL INPUT CARD
Widget _buildHorizontalInputCard(controller, context, String titleText, methodsController, bool isEncoding) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: cyberpunkDarkElevated,
          ),
          child: myInputfield(
            controller: controller,
            context: context,
            textTitle: titleText,
            hintText: 'ENTER DATA...',
            minLines: 3,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            onChanged: (value) {
              methodsController.onChange(controller: controller);
            },
            suffixIcon: _buildMobilePasteButton(),
            isEncode: true,
            isPlain: isEncoding,
            methodController: methodsController,
          ),
        ),
      ],
    ),
  );
}

// 🎯 HORIZONTAL METHODS CARD
Widget _buildHorizontalMethodsCard(methodsController, controller) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cyberpunkPurple.withOpacity(0.15),
          cyberpunkCyan.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: cyberpunkPurple.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.15),
          blurRadius: 14,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cyberpunkPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: cyberpunkPurple.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.tune,
                size: 16,
                color: cyberpunkPurple,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ALGORITHMS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: cyberpunkPurple,
                      fontFamily: 'monospace',
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'Select method',
                    style: TextStyle(
                      fontSize: 10,
                      color: cyberpunkPurple.withOpacity(0.8),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkPurple.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: methodsController.getOptionList(controller: controller),
        ),
      ],
    ),
  );
}

// 🎯 HORIZONTAL ADD CARD
Widget _buildHorizontalAddCard(controller, methodsController) {
  return Container(
    height: 44,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.2),
          cyberpunkPurple.withOpacity(0.15),
        ],
      ),
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 12,
          spreadRadius: 1,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          methodsController.addWidget(
            methodObj: CeaseCipher(), 
            controller: controller
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cyberpunkCyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(
                Icons.add,
                size: 16,
                color: cyberpunkCyan,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'ADD METHOD',
              style: TextStyle(
                fontSize: 11,
                color: cyberpunkCyan,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// 🎯 HORIZONTAL OUTPUT CARD
Widget _buildHorizontalOutputCard(controller, context, methodsController, bool isEncoding) {
  final textTitle = _getOutputTitle(controller);
  final hintText = "$textTitle...";

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        Container(
          decoration: const BoxDecoration(
            color: cyberpunkDarkElevated,
          ),
          child: myInputfield(
            controller: controller,
            context: context,
            textTitle: textTitle,
            hintText: hintText,
            readonly: true,
            methodController: methodsController,
            suffixIcon: _buildMobileCopyButton(controller, isEncoding),
            isEncode: false,
            isPlain: !isEncoding,
            minLines: 3,
            maxLines: 6,
          ),
        ),
      ],
    ),
  );
}

// 🎯 HORIZONTAL INFO CARD
Widget _buildHorizontalInfoCard(methodsController) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cyberpunkGreen.withOpacity(0.15),
          cyberpunkCyan.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: cyberpunkGreen.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkGreen.withOpacity(0.15),
          blurRadius: 14,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cyberpunkGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: cyberpunkGreen.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.info_outline,
                size: 16,
                color: cyberpunkGreen,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DETAILS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: cyberpunkGreen,
                      fontFamily: 'monospace',
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'Method info',
                    style: TextStyle(
                      fontSize: 10,
                      color: cyberpunkGreen.withOpacity(0.8),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkGreen.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Obx(() {
            return description(
              context: null,
              controller: methodsController,
            );
          }),
        ),
      ],
    ),
  );
}

// 🎯 MOBILE PASTE BUTTON
Widget _buildMobilePasteButton() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(6),
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.2),
          cyberpunkCyan.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.paste, color: cyberpunkCyan, size: 14),
        SizedBox(width: 4),
        Text(
          'PASTE',
          style: TextStyle(
            fontSize: 9,
            color: cyberpunkCyan,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}

// 🎯 MOBILE COPY BUTTON
Widget _buildMobileCopyButton(controller, bool isEncoding) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkPurple.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(6),
      gradient: LinearGradient(
        colors: [
          cyberpunkPurple.withOpacity(0.2),
          cyberpunkPurple.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        String cpy = isEncoding
            ? controller.cipherTextController.text.toString()
            : controller.plaintextController.text.toString();
        copyText(cpy);
      },
      borderRadius: BorderRadius.circular(6),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.copy, color: cyberpunkPurple, size: 14),
          SizedBox(width: 4),
          Text(
            'COPY',
            style: TextStyle(
              fontSize: 9,
              color: cyberpunkPurple,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ),
  );
}

String _getOutputTitle(controller) {
  if (controller is EncryptionController) {
    return "ENCRYPTED";
  } else if (controller is DecryptionController) {
    return "DECRYPTED";
  } else if (controller is EncodeController) {
    return "ENCODED";
  } else if (controller is DecodeController) {
    return "DECODED";
  }
  return "PROCESSED";
}

