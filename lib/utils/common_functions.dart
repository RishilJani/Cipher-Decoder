import 'package:cipher_decoder/utils/import_export.dart';

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
  if (!checkAllTypes(controller: controller) && controller is! TextEditingController) {
    throw ControllerTypeException(message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  TextEditingController ctr;
  if (isPlain) {
    if (key != null) {
      ctr = controller;
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
                  child:  enhancedClearIconButton(controller: controller, encryptionDecryptionOptionsController: methodController),
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

dynamic getMethod({required  element}){
  if(element is EncryptionDecryptionTypes){
    if(element == EncryptionDecryptionTypes.Ceaser_Cipher){ return new CeaseCipher();}
    else if(element == EncryptionDecryptionTypes.Atbash_Cipher){ return new AtbashCipher();}
    else if(element == EncryptionDecryptionTypes.Mono_Alphabatic_Cipher){ return new MonoAlphabaticCipher(); }
    else if(element == EncryptionDecryptionTypes.Rail_Fence_Cipher){ return new RailFenceCipher();}
  }
  else if(element is EncodeDecodeTypes){
    if(element == EncodeDecodeTypes.Base64){ return Base64(); }
    if(element == EncodeDecodeTypes.Base32){ return Base32(); }
  }
  else{
    throw ControllerTypeException(message: "encrypt decrypt element is not right ${element.runtimeType}");
  }
}

// region Description
Widget description({required context, controller}){
  if(controller is EncodeController || controller is DecodeController){
    return const SizedBox(height: 0,);
  }
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getDescriptionList(controller: controller,context: context),

        // character mapping for encryption decryption
        Visibility(
          visible: controller.desc.value != '',
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              controller.desc.value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF00FFFF),
                fontFamily: 'monospace',
                height: 1.4,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// to write multiple descriptions for encryption decryption
Widget _getDescriptionList({ controller , context}){
  List<String> temp = [];
  return ListView.builder(
    shrinkWrap: true,
    itemCount: controller is EncryptionDecryptionOptionsController ? controller.options.length : 1,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      bool isCame = false;
      String txt1;
      String description = "";
      if(controller is EncodeDecodeOptionController){
        txt1 = controller.selectedMethod.value.title!.toUpperCase();
        if(temp.contains(txt1)){
          isCame = true;
        }else{
          temp.add(txt1);
          description = controller.selectedMethod.value.description!;
        }
      }else{
        String name = controller.options[index].title!.toUpperCase();
        txt1 = '${index + 1}. $name';
        if(temp.contains(name)){
          isCame = true;
        }else{
          temp.add(name);
          description = controller.options[index].description!;
        }
      }

      return Visibility(
        visible: !isCame,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF41),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00FF41).withOpacity(0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    txt1 ,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00FF41),
                      fontFamily: 'monospace',
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF00FF41).withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00FF41).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: const Text(
                    'ACTIVE',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF00FF41),
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description with terminal-style divider
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: const Color(0xFF00FFFF).withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF00FFFF),
                  fontFamily: 'monospace',
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
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

// endregion

// region IconButtons

// region CLEAR BUTTON
Widget enhancedClearIconButton({
  required controller,
  required encryptionDecryptionOptionsController,
}) {
  return Container(
    height: 40,
    width: 40,
    margin: const EdgeInsets.only(left: 5,right: 10),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkRed.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [ cyberpunkRed.withOpacity(0.2),  cyberpunkRed.withOpacity(0.1),
        ],
      ),
    ),
    child: IconButton(
      icon: const Icon(Icons.clear, color: cyberpunkRed, size: 22),
      onPressed: () {
        controller.plainTextController.clear();
        controller.cipherTextController.clear();
        encryptionDecryptionOptionsController.onChange(controller: controller);
      },
      tooltip: 'CLEAR ALL DATA',
      // constraints: const BoxConstraints(
      //   minWidth: 44,
      //   minHeight: 44,
      // ),
    ),
  );
}
// endregion

// region PASTE BUTTON
Widget buildMobilePasteButton({controller, onChange}) {
  return Container(
    height: 40,
    width: 40,
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      border: Border.all(color: cyberpunkCyan.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(6),
      gradient: LinearGradient(
        colors: [
          cyberpunkCyan.withOpacity(0.2),
          cyberpunkCyan.withOpacity(0.1),
        ],
      ),
      // boxShadow: [
      //   BoxShadow(
      //     color: cyberpunkCyan.withOpacity(0.2),
      //     blurRadius: 6,
      //     spreadRadius: 1,
      //     offset: const Offset(0, 2),
      //   ),
      // ],
    ),
    child: InkWell(
        child: const Icon(Icons.paste, color: cyberpunkCyan, size: 22),
        onTap: () {
          pasteText(controller: controller, onChange: onChange);
        }
    ),
  );
}

// to paste text from clipboard
void pasteText({controller, required Function onChange}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {
    if (controller is EncodeController || controller is EncryptionController) {
      controller.plainTextController.text = data.text!;
    } else if (controller is DecodeController ||
        controller is DecryptionController) {
      controller.cipherTextController.text = data.text!;
    } else {
      throw ControllerTypeException(
          message:
          "Controller is not right in pasteText ${controller.runtimeType}");
    }
    onChange(controller: controller);
  }
}
// endregion

// region COPY BUTTON
Widget buildMobileCopyButton(controller, bool isEncoding) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    margin: const EdgeInsets.only(left: 5, right: 10),
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
            : controller.plainTextController.text.toString();
        copyText(cpy);
      },
      borderRadius: BorderRadius.circular(6),
      child: const Icon(Icons.copy, color: cyberpunkPurple, size: 22),
    ),
  );
}

// to copy text into clipboard
void copyText(String txt) {
  if (txt.isEmpty) {
    showSnackBar(
      title: "Empty Field",
      message: "There is nothing to copy.",
      colorText: cyberpunkGrayDark,
      backgroundColor: cyberpunkLightRed,
    );

  } else {
    Clipboard.setData(ClipboardData(text: txt)).then((value)
      {
          showSnackBar(
            title: "Success",
            message:  "Cipher text copied successfully",
            backgroundColor: cyberpunkGreenLight,
            colorText: cyberpunkDarkElevated,
          );
      }
    );
  }
}
// endregion


// endregion

bool checkAllTypes({controller}) {
  return controller is EncryptionController ||
      controller is DecryptionController ||
      controller is EncodeController ||
      controller is DecodeController;
}

void showSnackBar({title , message,  backgroundColor, colorText}) {
  Get.snackbar(title, message,
      duration: const Duration(seconds: 5),
      backgroundColor: backgroundColor,
      colorText: colorText,
      snackPosition: SnackPosition.BOTTOM
  );
}


PreferredSizeWidget buildEnhancedAppBar({title , content , bottom})   {
  return AppBar(
    title: Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [cyberpunkGreen, cyberpunkCyan],
          ).createShader(bounds),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'monospace',
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: cyberpunkGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cyberpunkGreen.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Text(
            content,
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
    backgroundColor: cyberpunkDark,
    elevation: 0,
    toolbarHeight: 75,

    bottom: bottom,
  );
}