import 'package:cipher_decoder/utils/import_export.dart';

class EncryptionDecryptionOptionsController extends GetxController {
  final int maxLimit = 5;
  RxString desc = ''.obs;
  RxList<EncryptionDecryptionMethods> options = <EncryptionDecryptionMethods>[CeaseCipher()].obs;

  void addWidget(
      {required EncryptionDecryptionMethods methodObj, required controller}) {
    if (options.length < maxLimit) {
      options.add(methodObj);
      onChange(controller: controller);
    } else {
      Get.snackbar("Max Limit Reached", "Can't add more methods",
          duration: const Duration(seconds: 5),
          backgroundColor: darkError,
          colorText: darkPrimary,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // on method change
  void updateWidget({methodObj, index, controller}) {
    options[index] = methodObj;
    onChange(controller: controller);
    update([EncryptionDecryptionMethods, bool]);
  }

  // on change plaint text / cipher text
  void onChange({controller}) {
    if (controller is EncryptionController) {
      String ans = controller.plainTextController.text;
      for (var met in options) {
        ans = controller.encryptUsing(method: met, encrypt: ans)!;
      }
      controller.cipherTextController.text = ans;
    } else if (controller is DecryptionController) {
      String ans = controller.cipherTextController.text;
      for (var met in options) {
        ans = controller.decryptUsing(method: met, decrypt: ans)!;
      }
      controller.plainTextController.text = ans;
    }

    changeDescription(controller: controller);
    update([String]);
  }

  // to change description according to methods
  void changeDescription({controller}) {
    if (controller is EncryptionController) {
      // desc.value = controller.dynamicDescription();
      desc.value = dynamicDescription(controller: controller);
    } else if (controller is DecryptionController) {
      // desc.value = controller.dynamicDescription();
      desc.value = dynamicDescription(controller: controller);
    }
  }

  void keyUpdateWidget({required index, controller}) {
    if (options[index].requiresKey) {
      options[index].key = controller.keyController.text.isNotEmpty
          ? int.parse(controller.keyController.text)
          : null;
    }
    if (controller is EncryptionController) {
      controller.encryptUsing(method: options[index]);
    } else if (controller is DecryptionController) {
      controller.decryptUsing(method: options[index]);
    }

    changeDescription(controller: controller);
    update([String]);
  }

  void removeWidget({index, controller}) {
    options.removeAt(index);
    onChange(controller: controller);
  }
}

Widget getOptionList({controller}) {
  var encodeDecodeOptionsController = Get.find<EncryptionDecryptionOptionsController>();

  return Obx(
    () => ListView.builder(
      shrinkWrap: true,
      itemCount: encodeDecodeOptionsController.options.length,
      itemBuilder: (context, index) {
        return EncryptionDecryptionOptions(
          controller: controller,
          index: index,
        );
      },
    ),
  );
}
