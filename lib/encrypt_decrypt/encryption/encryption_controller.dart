import 'package:cipher_decoder/utils/import_export.dart';

class EncryptionController extends GetxController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  // TextEditingController keyController = TextEditingController(text: '1');

  String? encryptUsing({required EncryptionDecryptionModel method, String? encrypt}) {
    if (encrypt != null) {
      String ans =method.encrypt(plainText: encrypt);
      if(method is CeaseCipher){
        print("input........ == ${encrypt}");
        print("ans  ........ == ${ans}");
      }
      return ans;
    } else {
      cipherTextController.text =
          method.encrypt(plainText: plainTextController.text);
      return null;
    }
  }
}
