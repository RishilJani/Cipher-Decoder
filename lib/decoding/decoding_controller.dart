import 'package:cipher_decoder/utils/import_export.dart';

class DecodingController {
  String decodeUsing({required String cipherText, required String method, int? key}) {
    DecodingModel decodingModel = DecodingModel();
    EncodeDecodeTypes met = fromString(method);

    if (met == EncodeDecodeTypes.Ceaser_Cipher) {
      return decodingModel.ceaserCipher(cipherText);
    } else if (met == EncodeDecodeTypes.Atbash_Cipher) {
      return decodingModel.atbashCipher(cipherText);
    } else if (met == EncodeDecodeTypes.Mono_Alphabatic_Cipher) {
      return decodingModel.monoAlphabaticCipher(cipherText: cipherText, key: key ?? 3);
    }
    return "";
  }
}
