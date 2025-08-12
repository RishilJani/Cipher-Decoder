import 'package:cipher_decoder/utils/import_export.dart';

class DecodingController {
  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController(text: '0');

  String? decodeUsing({required EncodeDecodeMethods method, String? decode}) {
    if (decode != null) {
      return method.decode(cipherText: decode);
    } else {
      plainTextController.text = method.decode(cipherText: cipherTextController.text);
      return null;
    }
  }

  String dynamicDescription({String? text1, String? text2}) {
    text1 ??= cipherTextController.text;
    text2 ??= plainTextController.text;

    String ans = '';
    int count = 0;
    String ignore = "\n ";
    var l1 = text1.split('');
    var l2 = text2.split('');
    for (int i = 0; i < l1.length; i++) {
      if (i == 0) {
        ans = "\ne.g.\n";
      }
      if (ignore.contains(l1[i])) {
        continue;
      }
      if (count == 7) {
        ans = "$ans...";
        break;
      }
      ans = "$ans${l1[i]} -> ${l2[i]}\n";
      count++;
    }
    return ans;
  }
}
