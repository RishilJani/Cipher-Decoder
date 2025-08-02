import 'package:cipher_decoder/utils/import_export.dart';

class KeyFieldController extends GetxController{
  var selectedMethod = encodeDecodeMethods.first.obs;

  RxBool showConditionalField = false.obs;
  
  void updateSelectedMethod(EncodeDecodeMethods method, {controller, isEncode = true}){
    selectedMethod.value = method;
    showConditionalField.value = method.requiresKey;

    onChange(isEncode: isEncode, controller: controller);
    Get.back();
  }

  void onChange({controller , bool isEncode = true}){
    // showConditionalField.value = selectedMethod.value.requiresKey;
    if(isEncode){
      print("Encoding Controller == ${controller.runtimeType}");
      controller.encodeUsing(method: selectedMethod.value);
    }else{
      print("Decoding Controller == ${controller.runtimeType}");
      controller.decodeUsing(method: selectedMethod.value);
    }
    print(".................Updating.................");
    update([bool,EncodeDecodeMethods]);
  }
}