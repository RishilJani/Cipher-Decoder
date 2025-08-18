import 'package:cipher_decoder/utils/import_export.dart';

class EncodeController{
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController(text: '1');

  String? encodeUsing({required EncodeDecodeModel method, String? encode}){
    if(encode != null){
      return method.encode(plainText: encode);
    }else{
      cipherTextController.text = method.encode(plainText: plainTextController.text);
      return null;
    }
  }
}