import 'package:cipher_decoder/utils/import_export.dart';

class EncodeDecodeOptionsController extends GetxController {
  final int maxLimit = 5;
  RxString desc = ''.obs;
  RxList<EncodeDecodeMethods> options =
      <EncodeDecodeMethods>[CeaseCipher()].obs;

  void addWidget(
      {required EncodeDecodeMethods methodObj, required controller}) {
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
    update([EncodeDecodeMethods, bool]);
  }

  // on change plaint text / cipher text
  void onChange({controller}) {
    if (controller is EncodingController) {
      String ans = controller.plainTextController.text;
      for (var met in options) {
        ans = controller.encodeUsing(method: met, encode: ans)!;
      }
      controller.cipherTextController.text = ans;
    } else if (controller is DecodingController) {
      String ans = controller.cipherTextController.text;
      for (var met in options) {
        ans = controller.decodeUsing(method: met, decode: ans)!;
      }
      controller.plainTextController.text = ans;
    }

    changeDescription(controller: controller);
    update([String]);
  }

  // to change description according to methods
  void changeDescription({controller}) {
    if (controller is EncodingController) {
      desc.value = controller.dynamicDescription();
    } else if (controller is DecodingController) {
      desc.value = controller.dynamicDescription();
    }
  }

  void keyUpdateWidget({required index, controller}) {
    if (options[index].requiresKey) {
      options[index].key = controller.keyController.text.isNotEmpty
          ? int.parse(controller.keyController.text)
          : null;
    }
    if (controller is EncodingController) {
      controller.encodeUsing(method: options[index]);
    } else if (controller is DecodingController) {
      controller.decodeUsing(method: options[index]);
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
  // controller == EncodingController || DecodingController
  var encodeDecodeOptionsController = Get.find<EncodeDecodeOptionsController>();

  return Obx(
    () => ListView.builder(
      shrinkWrap: true,
      itemCount: encodeDecodeOptionsController.options.length,
      itemBuilder: (context, index) {
        return EncodeDecodeOptions(
          controller: controller,
          index: index,
        );
      },
    ),
  );
}
