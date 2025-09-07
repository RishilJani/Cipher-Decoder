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

// region Icons

// CLEAR BUTTON
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
      // boxShadow: [
      //   BoxShadow(
      //     color: cyberpunkRed.withOpacity(0.2),
      //     blurRadius: 8,
      //     spreadRadius: 1,
      //     offset: const Offset(0, 2),
      //   ),
      // ],
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

// PASTE BUTTON
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

// COPY BUTTON
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


// endregion