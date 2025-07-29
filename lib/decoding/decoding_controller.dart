import 'package:cipher_decoder/utils/import_export.dart';

class DecodingController {
  String decodeUsing({required String cipherText, required EncodeDecodeMethods method, int? key}) {
    // EncodeDecodeMethods obj;
    // if(method == EncodeDecodeTypes.Ceaser_Cipher){
    //   obj = CeaseCipher();
    // }else if(method == EncodeDecodeTypes.Mono_Alphabatic_Cipher) {
    //   obj = MonoAlphabaticCipher();
    // }else if(method == EncodeDecodeTypes.Atbash_Cipher){
    //   obj = AtbashCipher();
    // }else if(method == EncodeDecodeTypes.Rail_Fence_Cipher){
    //   obj = RailFenceCipher();
    // } else{
    //   return "";
    // }
    return method.decode(cipherText: cipherText,key: key ?? 0);
  }
}

// DecodingModel decodingModel = DecodingModel();
//
// if (method == EncodeDecodeTypes.Ceaser_Cipher) {
//   return decodingModel.ceaserCipher(cipherText);
// } else if (method == EncodeDecodeTypes.Atbash_Cipher) {
//   return decodingModel.atbashCipher(cipherText);
// } else if (method == EncodeDecodeTypes.Mono_Alphabatic_Cipher) {
//   return decodingModel.monoAlphabaticCipher(cipherText: cipherText, key: key ?? 3);
// }else if(method == EncodeDecodeTypes.Rail_Fence_Cipher){
//   return decodingModel.railFenceCipher(cipherText: cipherText, key: key ?? 1);
// }
// return "";