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
  else if (context is DecodeController) {
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
          // region Encryption-Decryption
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
                if (controller is EncryptionController ||
                    controller is DecryptionController) {
                  methodsController.onChange(controller: controller);
                }
              },
              suffixIcon: pasteIconButton(
                  controller: controller, onChange: methodsController.onChange),
              isEncode: isEncoding!,
              methodController: methodsController),
          const SizedBox(height: height),
          // endregion

          isEncryption!
              ? methodsController.getOptionList( controller: controller)
              : const SizedBox(
                  height: 0,
                ),

          addOptionButton(controller: controller, methodController: methodsController),

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
                copyText(cpy);
              },
              icon: const Icon(Icons.copy),
              tooltip: "Copy encrypted text",
            ),
            isEncode: !isEncoding,
          ),
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
    methodController}) {
  if (!checkAllTypes(controller: controller)) {
    throw ControllerTypeException(
        message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  TextEditingController ctr;
  if (isEncode) {
    print(
        "IF :::::::: controller === ${controller.runtimeType} ::::: $isEncode");
    if (key != null) {
      ctr = controller.keyController;
    } else {
      ctr = controller.plainTextController;
    }
  } else {
    print(
        "ELSE :::::::: controller === ${controller.runtimeType} ::::: $isEncode");
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
    } else if (controller is DecodeController ||
        controller is DecryptionController) {
      controller.cipherTextController.text = data.text!;
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
      icon: const Icon(Icons.paste));
}

// clear Icon button
Widget clearIconButton(
    {controller, required encryptionDecryptionOptionsController}) {
  return IconButton(
    onPressed: () {
      controller!.plainTextController.clear();
      controller!.cipherTextController.clear();
      if (encryptionDecryptionOptionsController != null) {
        // encryptionDecryptionOptionsController.changeDescription(controller: controller);
        encryptionDecryptionOptionsController.desc.value = '';
      }
    },
    icon: const Icon(Icons.clear, color: darkError, size: 32),
    tooltip: "Clear",
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

  if(controller is EncryptionController || controller is EncodeController){
    text1 ??= controller.plainTextController.text;
    text2 ??= controller.cipherTextController.text;
  }
  else if(controller is DecryptionController || controller is DecodeController){
    text1 ??= controller.cipherTextController.text;
    text2 ??= controller.plainTextController.text;
  }
  else{
    throw ControllerTypeException(message: "Controller is Not right ::: ${controller.runtimeType}");
  }

  const int maxLimit = 10;
  String ans = '';
  int count = 0;
  String ignore = "\n ";
  var l1 = text1!.split('');
  var l2 = text2!.split('');
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
