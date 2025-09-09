import 'package:cipher_decoder/utils/import_export.dart';

Widget commonScreenLayout({
  required BuildContext context,
  required controller,
  required String titleText,
  required methodsController,
  bool isEncoding = true,
  bool isEncryption = true,
}) {
  if (!checkAllTypes(controller: controller)) {
    throw ControllerTypeException(
        message: "Controller Type is not right at modernScreenLayout");
  }

  if (methodsController is! EncodeDecodeOptionController &&
      methodsController is! EncryptionDecryptionOptionsController) {
    throw ControllerTypeException(
        message: "methodController Type is not right at modernScreenLayout");
  }
  return Scaffold(
    backgroundColor: cyberpunkDark,
    body: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // 🎯 INPUT CARD
                      buildInputCard(controller, context, titleText,
                          methodsController, isEncoding),

                      const SizedBox(height: 20),

                      // 🎯 METHODS CARD
                      buildMethodsCard(methodsController, controller),

                      if (isEncryption) ...[
                        const SizedBox(height: 20),
                        _buildHorizontalAddCard(controller, methodsController),
                      ],

                      const SizedBox(height: 20),

                      // 🎯 OUTPUT CARD
                      _buildHorizontalOutputCard(
                          controller, context, methodsController, isEncoding),

                      const SizedBox(height: 20),

                      // 🎯 INFO CARD
                      _buildHorizontalInfoCard(methodsController,context: context),

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

Widget buildInputCard(
    controller, context, String titleText, methodsController, bool isEncoding) {
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
            suffixIcon: buildMobilePasteButton(
                controller: controller, onChange: methodsController.onChange),
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
Widget buildMethodsCard(methodsController, controller) {
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
          methodsController.addWidget(controller: controller);
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
Widget _buildHorizontalOutputCard(
    controller, context, methodsController, bool isEncoding) {
  final textTitle = _getOutputTitle(controller);
  final hintText = "$textTitle...";

  return Column(
    children: [
      Container(
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
                suffixIcon: buildMobileCopyButton(controller, isEncoding),
                isEncode: false,
                minLines: 3,
                maxLines: 6,
                isPlain: !isEncoding,
              ),
            ),
          ],
        ),
      ),
      showDecodeLengthException(
          controller: controller, methodController: methodsController),
    ],
  );
}

// 🎯 HORIZONTAL INFO CARD
Widget _buildHorizontalInfoCard(methodsController, {context}) {
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
            // Icon
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
              context: context,
              controller: methodsController,
            );
          }),
        ),
      ],
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

Widget showDecodeLengthException({controller, methodController}) {
  if (methodController is EncodeDecodeOptionController &&
      controller is DecodeController) {
    return Obx(
      () {
        if (methodController.showError.value) {
          return const Text("Invalid Format to decode",
              style: TextStyle(color: Colors.red, fontSize: 16));
        } else {
          return const SizedBox(height: 0);
        }
      },
    );
  }
  return const SizedBox(height: 0);
}
