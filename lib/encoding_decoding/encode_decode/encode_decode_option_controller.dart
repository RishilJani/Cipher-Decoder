import 'package:cipher_decoder/utils/import_export.dart';

class EncodeDecodeOptionController extends GetxController{
    final int maxLimit = 2;
    RxString desc = ''.obs;
    RxList<EncodeDecodeModel> options = <EncodeDecodeModel>[Base64()].obs;
    RxBool showError = false.obs;

    void addWidget({required EncodeDecodeModel methodObj, required controller}){
      if (options.length < maxLimit) {
        options.add(methodObj);
        onChange(controller: controller);
      }else{
        showSnackBar();
      }
    }

    void updateWidget({required EncodeDecodeModel methodObj , index,  controller}){
      options[index] = methodObj;
      onChange(controller: controller);

      update([EncodeDecodeModel]);
    }

    void onChange({controller}) {
      if(controller is EncodeController){
        String ans = controller.plainTextController.text;
        for(var method in options){
          ans = controller.encodeUsing(method: method, encode: ans)!;
        }
        controller.cipherTextController.text = ans;
      }
      else if(controller is DecodeController){

        String ans = controller.cipherTextController.text;
        try {
          for (var method in options) {
            if(!method.validRegexp!.hasMatch(ans)){
              throw DecodeStringSizeException();
            }
            ans = controller.decodeUsing(method: method, decode: ans)!;
          }

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

    void removeWidget({index , controller}){

    }

    Widget getOptionList({controller}) {
      return Obx(
            () => ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            return EncodeDecodeOptions(
              controller: controller,
              encodeDecodeOptionController: this,
              index: index,
            );
          },
        ),
      );
    }
}