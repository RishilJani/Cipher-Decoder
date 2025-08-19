import 'package:cipher_decoder/utils/import_export.dart';

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
    }
    else if (controller is DecodeController || controller is DecryptionController) {
      print("Controller ==== ${controller.runtimeType}");
      controller.cipherTextController.text = data.text!;
    }else{
      throw ControllerTypeException(message: "Controller is not right in pasteText ${controller.runtimeType}");
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
      icon: const Icon(Icons.paste)
  );
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
