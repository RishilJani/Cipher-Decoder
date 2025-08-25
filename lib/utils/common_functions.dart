import 'package:cipher_decoder/utils/import_export.dart';
// custom Cyberpunk AppBar
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
              letterSpacing: 1.5,
            ),
          ),
        ),
        Text(
          '> TERMINAL ACTIVE',
          style: TextStyle(
            fontSize: 9,
            color: cyberpunkCyan.withOpacity(0.7),
            fontFamily: 'monospace',
            letterSpacing: 1,
          ),
        ),
      ],
    ),
    centerTitle: true,
    bottom: bottom,
    backgroundColor: cyberpunkDark,
    elevation: 0,
    leading: _cyberpunkIconButton(
      icon: Icons.arrow_back,
      onPressed: ()=> Get.back(),
      tooltip: "Back",
      minHeight: 26,
      minWidth: 26
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [cyberpunkDark, cyberpunkDarkElevated],
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
  const double height = 10;
  const double fieldSpacing = 20.0;

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

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // region Input Section
                _cyberpunkSectionHeader('> ${titleText.toUpperCase()}'),
                const SizedBox(height: 8),
                myInputfield(
                    controller: controller,
                    context: context,
                    textTitle: titleText,
                    hintText: 'ENTER DATA FOR PROCESSING...',
                    minLines: 3,
                    maxLines: 7,
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
                const SizedBox(height: height),
                // endregion

                // region Methods Section
                const SizedBox(height: 10),
                methodsController.getOptionList(controller: controller),

                methodsController is EncryptionDecryptionOptionsController ?
                _cyberpunkAddOptionButton(controller: controller, methodController: methodsController)
                    : const SizedBox(height: 0,),

                const SizedBox(height: fieldSpacing),
                // endregion

                // region Output Section
                _cyberpunkSectionHeader('> OUTPUT ${textTitle.toUpperCase()}'),
                const SizedBox(height: 8),
                myInputfield(
                    controller: controller,
                    context: context,
                    textTitle: textTitle,
                    hintText: hintText,
                    readonly: true,
                    methodController: methodsController,
                    suffixIcon: _cyberpunkIconButton(
                      icon: Icons.copy,
                      onPressed: () {
                        String cpy = isEncoding
                            ? controller.cipherTextController.text.toString()
                            : controller.plaintextController.text.toString();
                        copyText(cpy);
                      },
                      tooltip: "COPY DATA",
                      color: cyberpunkPurple,
                    ),
                    isEncode: false,
                    isPlain: !isEncoding
                ),
                _cyberpunkShowDecodeLengthException(methodController: methodsController, controller: controller),
                const SizedBox(height: fieldSpacing * 1.5),
                // endregion

                /* // region Status Section
                _cyberpunkStatusIndicator(),
                const SizedBox(height: fieldSpacing),
                // endregion */

                // region Description
                Obx(() {
                  return description(
                    context: context,
                    controller: methodsController,
                  );
                }),
                // endregion
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// cyberpunk styled text input field
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

  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: readonly
                  ? cyberpunkPurple.withOpacity(0.1)
                  : cyberpunkCyan.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: TextFormField(
          readOnly: readonly,
          controller: ctr,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: cyberpunkGreen.withOpacity(0.4),
              fontFamily: 'monospace',
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: readonly ? cyberpunkPurple : cyberpunkGreen,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: readonly ? cyberpunkPurple : cyberpunkGreen,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: readonly ? cyberpunkPurple : cyberpunkCyan,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: cyberpunkLightElevated,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                suffixIcon ?? const SizedBox(width: 0),
                isEncode
                    ? _cyberpunkClearIconButton(
                    controller: controller,
                    encryptionDecryptionOptionsController: methodController)
                    : const SizedBox(width: 0),
              ],
            ),
          ),
          style: const TextStyle(
            color: cyberpunkCyan,
            fontFamily: 'monospace',
            fontSize: 15,
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
      ),
      const SizedBox(height: 15.0),
    ],
  );
}

Widget _cyberpunkAddOptionButton({controller, required methodController}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    height: 40,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.1),
          cyberpunkPurple.withOpacity(0.1),
        ],
      ),
      border: Border.all(color: cyberpunkCyan, width: 1),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: cyberpunkCyan.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            onPressed: () {
              methodController.addWidget( methodObj: CeaseCipher(), controller: controller);
            },
            icon: const Icon(
              Icons.add,
              size: 20,
              color: cyberpunkCyan,
            ),
            tooltip: 'ADD CIPHER PROTOCOL',
          ),
        )
      ],
    ),
  );
}

Widget _cyberpunkIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  required String tooltip,
  Color color = cyberpunkPurple,
  double minWidth = 36,
  double minHeight = 36,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      gradient: LinearGradient(
        colors: [
          color.withOpacity(0.1),
          color.withOpacity(0.05),
        ],
      ),
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

Widget _cyberpunkClearIconButton({
  required controller,
  required encryptionDecryptionOptionsController,
}) {
  return _cyberpunkIconButton(
    icon: Icons.clear,
    onPressed: () {
      // Add your clear functionality here
      controller!.plainTextController.clear();
      controller!.cipherTextController.clear();
      if (encryptionDecryptionOptionsController != null) {
        encryptionDecryptionOptionsController.desc.value = '';
      }
    },
    tooltip: 'CLEAR DATA',
    color: cyberpunkRed,
  );
}

Widget _cyberpunkSectionHeader(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: cyberpunkCyan,
      fontFamily: 'monospace',
      letterSpacing: 1.2,
    ),
  );
}


/* // region Status Indicator
Widget _cyberpunkStatusIndicator() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cyberpunkGreen.withOpacity(0.1),
          Colors.transparent,
        ],
      ),
      border: Border.all(
        color: cyberpunkGreen.withOpacity(0.3),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: cyberpunkGreen,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          'SYSTEM STATUS: ONLINE',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: cyberpunkGreen,
          ),
        ),
      ],
    ),
  );
}
//endregion */


Widget _cyberpunkShowDecodeLengthException({controller, methodController}) {
  if(methodController is EncodeDecodeOptionController && controller is DecodeController){
    return Obx(() {
      if(methodController.showError.value){
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cyberpunkRed.withOpacity(0.1),
                cyberpunkRed.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: cyberpunkRed,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: cyberpunkRed.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: cyberpunkRed,
                size: 16,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "⚠ INVALID FORMAT DETECTED",
                  style: TextStyle(
                    color: cyberpunkRed,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
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

/*
IconButton(
      icon: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cyberpunkGreen, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: cyberpunkGreen,
          size: 20,
        ),
      ),
      onPressed: () => Get.back(),
    )
 */