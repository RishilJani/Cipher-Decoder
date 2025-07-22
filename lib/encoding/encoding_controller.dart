import 'package:cipher_decoder/utils/import_export.dart';
class EncodingController extends GetxController {
  EncodingModel encodingModel = EncodingModel();

  List<String> encodingList = [EN_CEASER_CIPHER, EN_ATBASH_CIPHER, EN_MONO_ALPHABATIC];
  List<String> keyRequired = [EN_MONO_ALPHABATIC];

  String encodeUsing({required String plainText,required String method, int? key}) {
    EncodeDecodeTypes met = fromString(method);
    if (met == EncodeDecodeTypes.Ceaser_Cipher) {
      print("cipher ================================");
      return encodingModel.ceaserCipher(plainText);
    }else if(met == EncodeDecodeTypes.Atbash_Cipher){
      return encodingModel.atbashCipher(plainText);
    }else if(met == EncodeDecodeTypes.Mono_Cipher){
      return encodingModel.monoAlphabaticCipher(plainText: plainText, key: key ?? 3);
    }
    return "";
  }

  EncodeDecodeTypes fromString(String s){
    if(s == EN_CEASER_CIPHER){
      return EncodeDecodeTypes.Ceaser_Cipher;
    }else if(s == EN_ATBASH_CIPHER){
      return EncodeDecodeTypes.Atbash_Cipher;
    }else{
      return EncodeDecodeTypes.Mono_Cipher;
    }
  }
}
