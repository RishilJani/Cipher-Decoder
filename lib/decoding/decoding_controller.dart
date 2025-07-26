import 'package:cipher_decoder/utils/import_export.dart';

class DecodingController {
  String decodeUsing({required String cipherText, required EncodeDecodeTypes method, int? key}) {
    DecodingModel decodingModel = DecodingModel();

    if (method == EncodeDecodeTypes.Ceaser_Cipher) {
      return decodingModel.ceaserCipher(cipherText);
    } else if (method == EncodeDecodeTypes.Atbash_Cipher) {
      return decodingModel.atbashCipher(cipherText);
    } else if (method == EncodeDecodeTypes.Mono_Alphabatic_Cipher) {
      return decodingModel.monoAlphabaticCipher(cipherText: cipherText, key: key ?? 3);
    }
    return "";
  }
}
