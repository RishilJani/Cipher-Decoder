import 'package:cipher_decoder/utils/import_export.dart';
class EncodingController extends GetxController {
  EncodingModel encodingModel = EncodingModel();

  String encodeUsing({required String plainText,required String method, int? key}) {
    EncodeDecodeTypes met = fromString(method);
    if (met == EncodeDecodeTypes.Ceaser_Cipher) {
      return encodingModel.ceaserCipher(plainText);
    }else if(met == EncodeDecodeTypes.Atbash_Cipher){
      return encodingModel.atbashCipher(plainText);
    }else if(met == EncodeDecodeTypes.Mono_Alphabatic_Cipher){
      return encodingModel.monoAlphabaticCipher(plainText: plainText, key: key ?? 3);
    }
    return "";
  }

}
