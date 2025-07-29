import 'package:cipher_decoder/utils/import_export.dart';
class EncodingController extends GetxController {
  // EncodingModel encodingModel = EncodingModel();

  String encodeUsing({required String plainText,required EncodeDecodeMethods method, int? key}) {
    return method.encode(plainText: plainText,key: key ?? 0);
  }
}
