import 'package:cipher_decoder/utils/import_export.dart';

// Modern Enhanced Screen Layout with sophisticated UI/UX
Widget enhancedScreenLayout({
  required BuildContext context,
  required controller,
  required String titleText,
  required methodsController,
  bool? isEncoding = true,
  bool? isEncryption = true,
}) {
  if (methodsController is! EncryptionDecryptionOptionsController && 
      methodsController is! EncodeDecodeOptionController) {
    throw ControllerTypeException(
        message: "Method Controller is Not right ::: ${controller.runtimeType}");
  }

  String textTitle;
  String hintText;

  if (controller is EncryptionController) {
    textTitle = "ENCRYPTED DATA";
  } else if (controller is DecryptionController) {
    textTitle = "DECRYPTED DATA";
  } else if (controller is EncodeController) {
    textTitle = "ENCODED DATA";
  } else if (controller is DecodeController) {
    textTitle = "DECODED DATA";
  } else {
    throw ControllerTypeException(
        message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  hintText = "$textTitle OUTPUT...";

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
            cyberpunkDark,
            cyberpunkDarkElevated,
            Color(0xFF16213E),
          ],
        ),
      ),
      child: Stack(
        children: [
          const MyBackgroundAnimation(),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Header Section
                  _buildModernHeader(titleText),
                  const SizedBox(height: 32),
                  
                  // Enhanced Input Section
                  _buildModernInputSection(
                    controller: controller,
                    context: context,
                    titleText: titleText,
                    hintText: 'ENTER DATA FOR PROCESSING...',
                    minLines: 5,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onChanged: (value) {
                      methodsController.onChange(controller: controller);
                    },
                    suffixIcon: _buildModernPasteButton(controller: controller, onChange: methodsController.onChange),
                    isEncode: true,
                    isPlain: isEncoding!,
                    methodController: methodsController
                  ),
                  const SizedBox(height: 32),
                  
                  // Enhanced Methods Section
                  _buildModernMethodsSection(methodsController, controller),
                  
                  if (methodsController is EncryptionDecryptionOptionsController)
                    _buildModernAddOptionButton(controller: controller, methodController: methodsController),
                  
                  const SizedBox(height: 40),
                  
                  // Enhanced Output Section
                  _buildModernOutputSection(
                    controller: controller,
                    context: context,
                    textTitle: textTitle,
                    hintText: hintText,
                    readonly: true,
                    methodController: methodsController,
                    isEncoding: isEncoding,
                  ),
                  
                  _buildModernErrorDisplay(methodController: methodsController, controller: controller),
                  const SizedBox(height: 40),
                  
                  // Enhanced Description Section
                  _buildModernDescriptionSection(methodsController),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildModernHeader(String titleText) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkPurple.withOpacity(0.15),
          cyberpunkCyan.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: cyberpunkPurple.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.2),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cyberpunkPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: cyberpunkPurple.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.input,
            size: 32,
            color: cyberpunkPurple,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: cyberpunkPurple,
                  fontFamily: 'monospace',
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Data Processing Terminal',
                style: TextStyle(
                  fontSize: 14,
                  color: cyberpunkCyan.withOpacity(0.8),
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildModernInputSection({
  required controller,
  required context,
  required String titleText,
  String? hintText,
  suffixIcon,
  required minLines,
  required maxLines,
  required keyboardType,
  required textInputAction,
  required onChanged,
  required bool isEncode,
  required bool isPlain,
  required methodController,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.15),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkCyan.withOpacity(0.25),
                cyberpunkCyan.withOpacity(0.15),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(
              color: cyberpunkCyan.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.input,
                size: 20,
                color: cyberpunkCyan,
              ),
              SizedBox(width: 12),
              Text(
                'INPUT DATA',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: cyberpunkCyan,
                  fontFamily: 'monospace',
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        myInputfield(
          controller: controller,
          context: context,
          textTitle: titleText,
          hintText: hintText,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          suffixIcon: suffixIcon,
          isEncode: isEncode,
          isPlain: isPlain,
          methodController: methodController,
        ),
      ],
    ),
  );
}

Widget _buildModernMethodsSection(methodsController, controller) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkPurple.withOpacity(0.15),
          cyberpunkCyan.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: cyberpunkPurple.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cyberpunkPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cyberpunkPurple.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.settings,
                size: 20,
                color: cyberpunkPurple,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'SELECT METHOD',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: cyberpunkPurple,
                fontFamily: 'monospace',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        methodsController.getOptionList(controller: controller),
      ],
    ),
  );
}

Widget _buildModernAddOptionButton({controller, required methodController}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    height: 56,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.25),
          cyberpunkPurple.withOpacity(0.15),
        ],
      ),
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          methodController.addWidget(methodObj: CeaseCipher(), controller: controller);
        },
        borderRadius: BorderRadius.circular(16),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 24,
              color: cyberpunkCyan,
            ),
            SizedBox(width: 12),
            Text(
              'ADD CIPHER PROTOCOL',
              style: TextStyle(
                fontSize: 14,
                color: cyberpunkCyan,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildModernOutputSection({
  required controller,
  required context,
  required String textTitle,
  required String hintText,
  required bool readonly,
  required methodController,
  required bool isEncoding,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.15),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkPurple.withOpacity(0.25),
                cyberpunkPurple.withOpacity(0.15),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(
              color: cyberpunkPurple.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.output,
                size: 20,
                color: cyberpunkPurple,
              ),
              SizedBox(width: 12),
              Text(
                'OUTPUT DATA',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: cyberpunkPurple,
                  fontFamily: 'monospace',
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        myInputfield(
          controller: controller,
          context: context,
          textTitle: textTitle,
          hintText: hintText,
          readonly: readonly,
          methodController: methodController,
          suffixIcon: _buildModernCopyButton(controller: controller, isEncoding: isEncoding),
          isEncode: false,
          isPlain: !isEncoding,
        ),
      ],
    ),
  );
}

Widget _buildModernCopyButton({required controller, required bool isEncoding}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkPurple.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          cyberpunkPurple.withOpacity(0.2),
          cyberpunkPurple.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkPurple.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      icon: const Icon(Icons.copy, color: cyberpunkPurple, size: 18),
      onPressed: () {
        String cpy = isEncoding
            ? controller.cipherTextController.text.toString()
            : controller.plaintextController.text.toString();
        copyText(cpy);
      },
      tooltip: 'COPY TO CLIPBOARD',
      constraints: const BoxConstraints(
        minWidth: 44,
        minHeight: 44,
      ),
    ),
  );
}

Widget _buildModernPasteButton({required controller, required Function onChange}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.2),
          cyberpunkCyan.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      icon: const Icon(Icons.paste, color: cyberpunkCyan, size: 18),
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
        minWidth: 44,
        minHeight: 44,
      ),
    ),
  );
}

Widget _buildModernDescriptionSection(methodsController) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkGreen.withOpacity(0.15),
          cyberpunkGreen.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: cyberpunkGreen.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkGreen.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cyberpunkGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cyberpunkGreen.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.info_outline,
                size: 20,
                color: cyberpunkGreen,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'OPERATION DETAILS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: cyberpunkGreen,
                fontFamily: 'monospace',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
                          Obx(() {
           return description(
             context: null,
             controller: methodsController,
           );
         }),
       ],
     ),
   );
 }

Widget _buildModernErrorDisplay({controller, methodController}) {
  if(methodController is EncodeDecodeOptionController && controller is DecodeController){
    return Obx(() {
      if(methodController.showError.value){
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkRed.withOpacity(0.2),
                cyberpunkRed.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: cyberpunkRed.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: cyberpunkRed.withOpacity(0.25),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cyberpunkRed.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: cyberpunkRed,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "⚠ INVALID FORMAT DETECTED",
                      style: TextStyle(
                        color: cyberpunkRed,
                        fontSize: 14,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Please check your input format and try again",
                      style: TextStyle(
                        color: cyberpunkRed.withOpacity(0.9),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox(height: 0);
      }
    });
  }
  return const SizedBox(height: 0);
}
