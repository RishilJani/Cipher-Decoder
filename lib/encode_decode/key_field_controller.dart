import 'package:cipher_decoder/utils/import_export.dart';

class KeyFieldController extends GetxController{
  var selectedMethod = encodeDecodeMethods.first.obs;
  RxBool showConditionalField = false.obs;
  RxString ans = ''.obs;

  void updateSelectedMethod(EncodeDecodeMethods method, {controller}){
    selectedMethod.value = method;
    showConditionalField.value = method.requiresKey;

    onChange( controller: controller );
    update([EncodeDecodeMethods,bool]);
    Get.back();
  }

  void onChange({ controller }){
    if(controller is EncodingController){
      controller.encodeUsing(method: selectedMethod.value);
    }else if(controller is DecodingController){
      controller.decodeUsing(method: selectedMethod.value);
    }
    changeDescription(controller:controller);
    print(".............Updating.....................");
    print("ans = ${ans.value}");

    update([String]);
  }

  void changeDescription({ controller }){
    if(controller is EncodingController){
      ans.value = selectedMethod.value.explanation(text1: controller.plainTextController.text, text2: controller.cipherTextController.text);
    }else if(controller is DecodingController){
      ans.value = selectedMethod.value.explanation(text1: controller.cipherTextController.text, text2: controller.cipherTextController.text);
    }
  }
}