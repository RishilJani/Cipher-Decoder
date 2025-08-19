import 'package:cipher_decoder/encoding_decoding/encode_decode/encode_decode_options.dart';
import 'package:cipher_decoder/utils/import_export.dart';

class EncodeDecodeOptionController extends GetxController{
    final int maxLimit = 2;
    RxString desc = ''.obs;
    RxList<EncodeDecodeModel> options = <EncodeDecodeModel>[Base64()].obs;

    void addWidget({required EncodeDecodeModel methodObj, required controller}){

    }

    void updateWidget({required EncodeDecodeModel methodObj , index,  controller}){
      options[index] = methodObj;
      onChange(controller: controller);

      update([EncodeDecodeModel]);
    }

    void onChange({controller}){
      print("ON CHANGED::::::: ..........");
      if(controller is EncodeController){
        String ans = controller.plainTextController.text;
        for(var method in options){
          ans = controller.encodeUsing(method: method, encode: ans)!;
        }
        controller.cipherTextController.text = ans;
      }
      else if(controller is DecodeController){
        String ans = controller.cipherTextController.text;
        for(var method in options){
          try {
            ans = controller.decodeUsing(method: method, decode: ans)!;
          }catch(e){
            print("\n\n::::::::::::: ERROR :::::::::::\n\n");
          }
        }
        print("ANS ==== $ans");
        controller.plainTextController.text = ans;
      }
      else{
        throw ControllerTypeException(message: "Encode Decode Controller is Not right ::: ${controller.runtimeType}");
      }

      // print("ON CHANGED::::::: ..........");
      changeDescription(controller: controller);
      update([String]);

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