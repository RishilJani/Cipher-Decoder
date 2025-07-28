import 'package:cipher_decoder/utils/import_export.dart';
class EncodingController extends GetxController {
  EncodingModel encodingModel = EncodingModel();

  String encodeUsing({required String plainText,required EncodeDecodeTypes method, int? key}) {
    if (method == EncodeDecodeTypes.Ceaser_Cipher) {
      return encodingModel.ceaserCipher(plainText);
    }else if(method == EncodeDecodeTypes.Atbash_Cipher){
      return encodingModel.atbashCipher(plainText);
    }else if(method == EncodeDecodeTypes.Mono_Alphabatic_Cipher){
      return encodingModel.monoAlphabaticCipher(plainText: plainText, key: key ?? 3);
    }else if(method == EncodeDecodeTypes.Rail_Fence_Cipher){
      return encodingModel.railFence(plainText: plainText, key: key ?? 1);
    }
    return "";
  }

}
