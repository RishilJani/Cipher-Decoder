import 'package:cipher_decoder/utils/import_export.dart';

class DecodeController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController(text: '0');

  String? decodeUsing({required EncodeDecodeModel method, String? decode}){
    if(decode != null){
      return method.decode(encodedText: decode);
    }else{
      plainTextController.text = method.decode(encodedText: cipherTextController.text);
      return null;
    }
  }
}
/*
A single remaining encoded character in the last quadruple or a padding of 3 characters is not allowed
 */