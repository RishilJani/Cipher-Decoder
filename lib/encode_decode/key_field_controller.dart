import 'package:cipher_decoder/utils/import_export.dart';

class KeyFieldController extends GetxController{
  var selectedMethod = encodeDecodeMethods.first.obs;
  RxBool showConditionalField = false.obs;
  RxString ans = ''.obs;

  void updateSelectedMethod(EncodeDecodeMethods method, {controller, isEncode = true}){
    selectedMethod.value = method;
    showConditionalField.value = method.requiresKey;

    onChange(isEncode: isEncode, controller: controller);
    update([EncodeDecodeMethods,bool]);
    Get.back();
  }

  void onChange({ controller , bool isEncode = true}){
    if(isEncode){
      controller.encodeUsing(method: selectedMethod.value);
      ans.value = selectedMethod.value.explanation(text1: controller.plainTextController.text, text2: controller.cipherTextController.text);
    }else{
      controller.decodeUsing(method: selectedMethod.value);
      ans.value = selectedMethod.value.explanation(text1: controller.cipherTextController.text, text2: controller.cipherTextController.text);
    }
    print(".............Updating.....................");
    print("ans = ${ans.value}");

    update([String]);
  }

}