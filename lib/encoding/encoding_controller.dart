import 'package:cipher_decoder/utils/import_export.dart';
class EncodingController extends GetxController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController(text: '1');

  RxList<dynamic> methods= [].obs;

  void encodeUsing({required EncodeDecodeMethods method}) {
    int? k = keyController.text.isNotEmpty  ? int.parse(keyController.text)  : null;

    cipherTextController.text =method.encode(plainText: plainTextController.text,key: k ?? 0);

  }
}
