import 'package:cipher_decoder/utils/import_export.dart';

class EncryptionController extends GetxController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController(text: '1');

  String? encryptUsing({required EncryptionDecryptionMethods method, String? encrypt}) {
    if (encrypt != null) {
      return method.encrypt(plainText: encrypt);
    } else {
      cipherTextController.text = method.encrypt(plainText: plainTextController.text);
      return null;
    }
  }

}
