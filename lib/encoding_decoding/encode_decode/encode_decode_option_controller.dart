import 'package:cipher_decoder/utils/import_export.dart';

class EncodeDecodeOptionController extends GetxController{
    // final int maxLimit = 2;
    RxString desc = ''.obs;
    Rx<EncodeDecodeModel> selectedMethod = (Base64() as EncodeDecodeModel).obs;
    RxBool showError = false.obs;


    void updateWidget({required EncodeDecodeModel methodObj ,  controller}){
      selectedMethod.value = methodObj;
      onChange(controller: controller);
      update([EncodeDecodeModel]);
    }

    void onChange({controller}) {
      if(controller is EncodeController){
        String ans = controller.plainTextController.text;
        ans = controller.encodeUsing(method: selectedMethod.value, encode: ans)!;
        controller.cipherTextController.text = ans;
      }
      else if(controller is DecodeController){

        String ans = controller.cipherTextController.text;
        try {

          if(!selectedMethod.value.validRegexp!.hasMatch(ans)){
            throw DecodeStringSizeException();
          }
          ans = controller.decodeUsing(method: selectedMethod.value, decode: ans)!;

          controller.plainTextController.text = ans;
          showError.value = false;
        } catch(e){
          showError.value = true;
          update([bool]);
          return;
        }
      }
      else{
        throw ControllerTypeException(message: "Encode Decode Controller is Not right ::: ${controller.runtimeType}");
      }

      changeDescription(controller: controller);
      update([String, bool]);
    }

    void changeDescription({controller}){
      if (controller is EncodeController) {
        desc.value = dynamicDescription(controller: controller);
      }
      else if (controller is DecodeController) {
        desc.value = dynamicDescription(controller: controller);
      }
      else{
        throw ControllerTypeException(message: "Encryption Decryption Controller is Not right ::: ${controller.runtimeType}");
      }
    }

    Widget getOptionList({controller}) {
      return EncodeDecodeOptions( controller: controller,  encodeDecodeOptionController: this,);
    }
}