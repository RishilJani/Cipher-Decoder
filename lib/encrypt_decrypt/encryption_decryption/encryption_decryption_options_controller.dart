import 'package:cipher_decoder/utils/import_export.dart';

class EncryptionDecryptionOptionsController extends GetxController {
  final int maxLimit = 5;
  RxString desc = ''.obs;
  RxList<EncryptionDecryptionModel> options = <EncryptionDecryptionModel>[CeaseCipher()].obs;

  void addWidget({required controller}) {
    EncryptionDecryptionModel methodObj = CeaseCipher();
    if (options.length < maxLimit) {
      options.add(methodObj);
      onChange(controller: controller);
    } else {
      showSnackBar(
          title: "Max Limit Reached",
          message: "Can't add more methods",
          backgroundColor: cyberpunkDarkElevated,
          colorText: cyberpunkGreen);
    }
  }

  // on method change
  void updateWidget(
      {required EncryptionDecryptionModel methodObj, index, controller}) {
    options[index] = methodObj;
    onChange(controller: controller);
    update([EncryptionDecryptionModel]);
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
    } else {
      throw ControllerTypeException(
          message: "Encryption Decryption Controller is Not right ::: ${controller.runtimeType}");
    }

    changeDescription(controller: controller);
    update([String]);
  }

  // to change description according to methods
  void changeDescription({controller}) {
    if (controller is EncryptionController) {
      desc.value = dynamicDescription(controller: controller);
    } else if (controller is DecryptionController) {
      desc.value = dynamicDescription(controller: controller);
    } else {
      throw ControllerTypeException(
          message: "Encryption Decryption Controller is Not right ::: ${controller.runtimeType}");
    }
  }

  void keyUpdateWidget({required index, controller}) {
    if (controller is EncryptionController) {
      controller.encryptUsing(method: options[index]);
    } else if (controller is DecryptionController) {
      controller.decryptUsing(method: options[index]);
    }

    onChange(controller: controller);
  }

  void removeWidget({index, controller}) {
    options.removeAt(index);
    onChange(controller: controller);
  }

  Widget getOptionList({controller}) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return EncryptionDecryptionOptions(
            controller: controller,
            encryptionDecryptionOptionController: this,
            index: index,
          );
        },
      );
    });
  }
}
