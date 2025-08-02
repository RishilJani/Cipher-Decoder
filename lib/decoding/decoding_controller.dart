import 'package:cipher_decoder/utils/import_export.dart';

class DecodingController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  void decodeUsing({required EncodeDecodeMethods method}) {
    int? k = keyController.text.isNotEmpty  ? int.parse(keyController.text)  : null;

    plainTextController.text = method.decode(cipherText: cipherTextController.text,key: k ?? 0);
  }
}