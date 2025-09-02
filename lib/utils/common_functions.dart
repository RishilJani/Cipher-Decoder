import 'package:cipher_decoder/utils/import_export.dart';

// Enhanced Cyberpunk AppBar with better visual design
AppBar myAppBar({String title = '', required context, bottom}) {
  return AppBar(
    title: Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [cyberpunkGreen, cyberpunkCyan],
          ).createShader(bounds),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'monospace',
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: cyberpunkGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkGreen.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: const Text(
            '> TERMINAL ACTIVE',
            style: TextStyle(
              fontSize: 9,
              color: cyberpunkGreen,
              fontFamily: 'monospace',
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
    centerTitle: true,
    bottom: bottom,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: _enhancedCyberpunkIconButton(
      icon: Icons.arrow_back,
      onPressed: () => Get.back(),
      tooltip: "RETURN TO PREVIOUS",
      minHeight: 40,
      minWidth: 40,
      color: cyberpunkCyan,
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            cyberpunkDark,
            cyberpunkDarkElevated,
          ],
        ),
      ),
    ),
  );
}

Widget myScreen({required BuildContext context,
  controller,
  titleText,
  methodsController,
  bool? isEncoding = true,
  bool? isEncryption = true}) {
  if (methodsController is! EncryptionDecryptionOptionsController && methodsController is! EncodeDecodeOptionController)
  {
    throw ControllerTypeException(
        message:
        "Method Controller is Not right ::: ${controller.runtimeType}");
  }

  String textTitle;
  String hintText;

  if (controller is EncryptionController) {
    textTitle = "ENCRYPTED DATA";
  }
  else if (controller is DecryptionController) {
    textTitle = "DECRYPTED DATA";
  }
  else if (controller is EncodeController) {
    textTitle = "ENCODED DATA";
  }
  else if (controller is DecodeController) {
    textTitle = "DECODED DATA";
  }
  else {
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Section
                  // _enhancedCyberpunkSectionHeader('> ${titleText.toUpperCase()}', Icons.input),
                  // const SizedBox(height: 16),
                  myInputfield(
                      controller: controller,
                      context: context,
                      textTitle: titleText,
                      hintText: 'ENTER DATA FOR PROCESSING...',
                      minLines: 4,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      onChanged: (value) {
                        methodsController.onChange(controller: controller);
                      },
                      suffixIcon: pasteIconButton(controller: controller, onChange: methodsController.onChange),
                      isEncode: true,
                      isPlain: isEncoding!,
                      methodController: methodsController
                  ),
                  const SizedBox(height: 24),

                  // Methods Section
                  const SizedBox(height: 16),
                  methodsController.getOptionList(controller: controller),

                  // add button
                  Visibility(
                    visible: methodsController is EncryptionDecryptionOptionsController ,
                    child: _enhancedAddOptionButton(controller: controller, methodController: methodsController)
                  ),

                  const SizedBox(height: 32),

                  // Output Section
                  // _enhancedCyberpunkSectionHeader('> OUTPUT ${textTitle.toUpperCase()}', Icons.output),
                  // const SizedBox(height: 16),
                  myInputfield(
                      controller: controller,
                      context: context,
                      textTitle: textTitle,
                      hintText: hintText,
                      readonly: true,
                      methodController: methodsController,
                      suffixIcon: _enhancedCyberpunkIconButton(
                        icon: Icons.copy,
                        onPressed: () {
                          String cpy = isEncoding
                              ? controller.cipherTextController.text.toString()
                              : controller.plaintextController.text.toString();
                          copyText(cpy);
                        },
                        tooltip: "COPY DATA",
                        color: cyberpunkPurple,
                        minWidth: 44,
                        minHeight: 44,
                      ),
                      isEncode: false,
                      isPlain: !isEncoding
                  ),
                  _enhancedShowDecodeLengthException(methodController: methodsController, controller: controller),
                  const SizedBox(height: 32),

                  // Description
                  Obx(() {
                    return description(
                      context: context,
                      controller: methodsController,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Enhanced cyberpunk styled text input field
Widget myInputfield(
    {key,
      required context,
      required String textTitle,
      String? hintText,
      suffixIcon,
      required controller,
      minLines,
      maxLines,
      keyboardType,
      textInputAction,
      inputFormatters,
      onChanged,
      validator,
      bool readonly = false,
      bool isEncode = true,
      bool isPlain  = true,
      methodController})
{
  if (!checkAllTypes(controller: controller)) {
    throw ControllerTypeException(
        message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  TextEditingController ctr;
  if (isPlain) {
    if (key != null) {
      ctr = controller.keyController;
    }
    else {
      ctr = controller.plainTextController;
    }
  }
  else {
    ctr = controller.cipherTextController;
  }

  return Container(
    key: key,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: readonly
              ? cyberpunkPurple.withOpacity(0.15)
              : cyberpunkCyan.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkCyan.withOpacity(0.2),
                cyberpunkCyan.withOpacity(0.1),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border.all(
              color: readonly ? cyberpunkPurple.withOpacity(0.3) : cyberpunkCyan.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                readonly ? Icons.output : Icons.input,
                size: 16,
                color: cyberpunkCyan,
              ),
              const SizedBox(width: 8),
              Text(
                textTitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cyberpunkCyan,
                  fontFamily: 'monospace',
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          readOnly: readonly,
          controller: ctr,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: cyberpunkGreen.withOpacity(0.4),
              fontFamily: 'monospace',
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: cyberpunkCyan.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: cyberpunkCyan.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: cyberpunkCyan,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: cyberpunkLightElevated,
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                suffixIcon ?? const SizedBox(width: 0),
                Visibility(
                  visible: isEncode,
                  child:  _enhancedClearIconButton(controller: controller, encryptionDecryptionOptionsController: methodController),
                ),
              ],
            ),
          ),
          style: const TextStyle(
            color: cyberpunkCyan,
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.4,
          ),
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          enableSuggestions: true,
          enableInteractiveSelection: true,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
        ),
      ],
    ),
  );
}

Widget _enhancedAddOptionButton({controller, required methodController}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    height: 48,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.2),
          cyberpunkPurple.withOpacity(0.1),
        ],
      ),
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          methodController.addWidget( methodObj: CeaseCipher(), controller: controller);
        },
        borderRadius: BorderRadius.circular(12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 20,
              color: cyberpunkCyan,
            ),
            SizedBox(width: 8),
            Text(
              'ADD CIPHER PROTOCOL',
              style: TextStyle(
                fontSize: 12,
                color: cyberpunkCyan,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _enhancedCyberpunkIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  required String tooltip,
  Color color = cyberpunkPurple,
  double minWidth = 44,
  double minHeight = 44,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          color.withOpacity(0.2),
          color.withOpacity(0.1),
        ],
      ),
      border: Border.all(
        color: color.withOpacity(0.4),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      icon: Icon(icon, color: color, size: 20),
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
      ),
    ),
  );
}

Widget _enhancedClearIconButton({
  required controller,
  required encryptionDecryptionOptionsController,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkRed.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          cyberpunkRed.withOpacity(0.2),
          cyberpunkRed.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: cyberpunkRed.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      icon: const Icon(Icons.clear, color: cyberpunkRed, size: 18),
      onPressed: () {
        controller.plainTextController.clear();
        controller.cipherTextController.clear();
        encryptionDecryptionOptionsController.onChange(controller: controller);
      },
      tooltip: 'CLEAR ALL DATA',
      constraints: const BoxConstraints(
        minWidth: 44,
        minHeight: 44,
      ),
    ),
  );
}

Widget _enhancedShowDecodeLengthException({controller, methodController}) {
  if(methodController is EncodeDecodeOptionController && controller is DecodeController){
    return Obx(() {
      if(methodController.showError.value){
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkRed.withOpacity(0.15),
                cyberpunkRed.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: cyberpunkRed.withOpacity(0.4),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: cyberpunkRed.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cyberpunkRed.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: cyberpunkRed,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "⚠ INVALID FORMAT DETECTED",
                      style: TextStyle(
                        color: cyberpunkRed,
                        fontSize: 12,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Please check your input format and try again",
                      style: TextStyle(
                        color: cyberpunkRed.withOpacity(0.8),
                        fontSize: 11,
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

bool checkAllTypes({controller}) {
  return controller is EncryptionController ||
      controller is DecryptionController ||
      controller is EncodeController ||
      controller is DecodeController;
}

String dynamicDescription({controller,String? text1, String? text2}) {

  if(controller is EncryptionController){
    text1 ??= controller.plainTextController.text;
    text2 ??= controller.cipherTextController.text;
  }
  else if(controller is DecryptionController){
    text1 ??= controller.cipherTextController.text;
    text2 ??= controller.plainTextController.text;
  }else if(controller is DecodeController || controller is EncodeController){
    return '';
  }
  else{
    throw ControllerTypeException(message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  const int maxLimit = 10;
  String ans = '';
  int count = 0;
  String ignore = "\n ";
  var l1 = text1.split('');
  var l2 = text2.split('');
  for (int i = 0; i < l1.length; i++) {
    if (i == 0) {
      ans = "\n> CIPHER MAP:\n";
    }

    if (ignore.contains(l1[i])) {
      continue;
    }

    if (count == maxLimit) {
      ans = "$ans...";
      break;
    }
    ans = "$ans${l1[i]} → ${l2[i]}\n";
    count++;
  }
  return ans;
}

dynamic getMethod({required  element}){
  if(element is EncryptionDecryptionTypes){
    if(element == EncryptionDecryptionTypes.Ceaser_Cipher){ return CeaseCipher();}
    else if(element == EncryptionDecryptionTypes.Atbash_Cipher){ return AtbashCipher();}
    else if(element == EncryptionDecryptionTypes.Mono_Alphabatic_Cipher){ return MonoAlphabaticCipher(key: 1); }
    else if(element == EncryptionDecryptionTypes.Rail_Fence_Cipher){ return RailFenceCipher(key: 1);}
  }
  else if(element is EncodeDecodeTypes){
    if(element == EncodeDecodeTypes.Base64){ return Base64(); }
    if(element == EncodeDecodeTypes.Base32){ return Base32(); }
  }
  else{
    throw ControllerTypeException(message: "encrypt decrypt element is not right ${element.runtimeType}");
  }
}