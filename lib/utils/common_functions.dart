import 'package:cipher_decoder/utils/import_export.dart';

// custom Appbar
AppBar myAppBar({String title = '', required context, bottom}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return AppBar(
    title: Text(title, style: textTheme.titleLarge),
    centerTitle: true,
    bottom: bottom,
  );
}

Widget myScreen({required BuildContext context,
    controller,
    titleText,
    methodsController,
    bool? isEncoding = true,
    bool? isEncryption = true}) {
  if (methodsController is! EncryptionDecryptionOptionsController && methodsController is! EncodeDecodeOptionController) {
    throw ControllerTypeException(
        message:
            "Method Controller is Not right ::: ${controller.runtimeType}");
  }

  String textTitle;
  String hintText;
  const double height = 10;
  const double fieldSpacing = 20.0;

  if (controller is EncryptionController) {
    textTitle = "Encrypted Text";
  }
  else if (controller is DecryptionController) {
    textTitle = "Decrypted Text";
  }
  else if (controller is EncodeController) {
    textTitle = "Encoded Text";
  }
  else if (controller is DecodeController) {
    textTitle = "Decoded Text";
  }
  else {
    throw ControllerTypeException(
        message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  hintText = "$textTitle....";

  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // region Encryption-Encoding
          myInputfield(
              controller: controller,
              context: context,
              textTitle: titleText,
              hintText: titleText,
              minLines: 3,
              maxLines: 7,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onChanged: (value) {
                  // on change function here
                  methodsController.onChange(controller: controller);
              },
              suffixIcon: pasteIconButton(controller: controller, onChange: methodsController.onChange),
              isEncode: true,
              isPlain: isEncoding!,
              methodController: methodsController
          ),
          const SizedBox(height: height),
          // endregion

          methodsController.getOptionList(controller: controller),

          methodsController is EncryptionDecryptionOptionsController ?
              addOptionButton(controller: controller, methodController: methodsController)
              : const SizedBox(height: 0,),

          const SizedBox(height: fieldSpacing),

          // region Encrypted-Decrypted
            myInputfield(
              controller: controller,
              context: context,
              textTitle: textTitle,
              hintText: hintText,
              readonly: true,
              methodController: methodsController,
              suffixIcon: IconButton(
                onPressed: () {
                  String cpy = isEncoding
                      ? controller.cipherTextController.text.toString()
                      : controller.plaintextController.text.toString();

                  // print("Controller ===== ${controller.runtimeType}");
                  copyText(cpy);
                },
                icon: const Icon(Icons.copy),
                tooltip: "Copy encrypted text",
              ),
              isEncode: false,
              isPlain: !isEncoding
            ),
          showDecodeLengthException(methodController: methodsController, controller: controller),
          const SizedBox(height: fieldSpacing * 1.5),
          // endregion

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
  );
}

// custom text input field
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
    methodController}) {
  if (!checkAllTypes(controller: controller)) {
    throw ControllerTypeException(
        message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
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
      Text(
        textTitle,
        style: textTheme.titleMedium,
      ),
      const SizedBox(height: 10.0),
      TextFormField(
          readOnly: readonly,
          controller: ctr,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  suffixIcon ?? const SizedBox(width: 0),
                  isEncode
                      ? clearIconButton(
                          controller: controller,
                          encryptionDecryptionOptionsController:
                              methodController)
                      : const SizedBox(width: 0),
                ],
              ),
              suffixIconColor: darkSurface),
          style: textTheme.bodyMedium?.copyWith(color: darkElevatedSurface),
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          enableInteractiveSelection: true,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters),
      const SizedBox(height: 15.0),
    ],
  );
}

Widget addOptionButton({controller, required methodController}) {
  return Container(
    decoration: BoxDecoration(
        color: darkElevatedSurface,
        border: Border.all(color: darkAccent, width: 3),
        borderRadius: BorderRadius.circular(15)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
              onPressed: () {
                methodController.addWidget( methodObj: CeaseCipher(), controller: controller);
              },
              hoverColor: Colors.red,
              icon: const Icon( Icons.add,  size: 25, )
          ),
        )
      ],
    ),
  );
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
      ans = "\ne.g.\n";
    }

    if (ignore.contains(l1[i])) {
      continue;
    }

    if (count == maxLimit) {
      ans = "$ans...";
      break;
    }
    ans = "$ans${l1[i]} -> ${l2[i]}\n";
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

Widget showDecodeLengthException({controller , methodController}){
  if(methodController is EncodeDecodeOptionController && controller is DecodeController){
    return Obx(() {
      if(methodController.showError.value){
        return const Text("Invalid Format", style: TextStyle(color: Colors.red, fontSize: 16) );
      }else{
        return const SizedBox(height: 0);
      }
    },);
  }
  return const SizedBox(height: 0);
}