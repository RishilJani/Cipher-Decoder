import 'package:cipher_decoder/utils/import_export.dart';

// Map<dynamic,dynamic> methods = {
//   EncodeDecodeTypes.Ceaser_Cipher : CEASER_CIPHER_DESC,
//   EncodeDecodeTypes.Atbash_Cipher : ATBASH_CIPHER_DESC,
//   EncodeDecodeTypes.Mono_Alphabatic_Cipher : MONO_ALPHABATIC_CIPHER_DESC,
//   EncodeDecodeTypes.Rail_Fence_Cipher : RAIL_FENCE_DESC,
// };

List<EncodeDecodeMethods> _encodeDecodeMethods = [];

List<EncodeDecodeMethods> get encodeDecodeMethods {
  if(_encodeDecodeMethods.isEmpty){
    for (EncodeDecodeTypes element in EncodeDecodeTypes.values) {
      if(element == EncodeDecodeTypes.Ceaser_Cipher){ _encodeDecodeMethods.add(CeaseCipher());}
      else if(element == EncodeDecodeTypes.Atbash_Cipher){ _encodeDecodeMethods.add(AtbashCipher());}
      else if(element == EncodeDecodeTypes.Mono_Alphabatic_Cipher){ _encodeDecodeMethods.add(MonoAlphabaticCipher());}
      else if(element == EncodeDecodeTypes.Rail_Fence_Cipher){ _encodeDecodeMethods.add(RailFenceCipher());}
    }
  }
  return _encodeDecodeMethods;
}

// to convert EncodeDecodeTypes into String
String encodeDecodeToString(EncodeDecodeTypes method){
  if(method == EncodeDecodeTypes.Mono_Alphabatic_Cipher){
    return EN_MONO_ALPHABATIC;
  }
  else if(method == EncodeDecodeTypes.Atbash_Cipher){
    return EN_ATBASH_CIPHER;
  }
  else if(method == EncodeDecodeTypes.Ceaser_Cipher){
    return EN_CEASER_CIPHER;
  }
  else if(method == EncodeDecodeTypes.Rail_Fence_Cipher) {return EN_RAIL_FENCE;}
  return "";
}

// to convert String into EncodeDecodeTypes enum
// EncodeDecodeTypes encodeDecodeFromString(String s) {
//   if(s == EN_CEASER_CIPHER){
//     return EncodeDecodeTypes.Ceaser_Cipher;
//   }else if(s == EN_ATBASH_CIPHER){
//     return EncodeDecodeTypes.Atbash_Cipher;
//   }else if(s == EN_MONO_ALPHABATIC){
//     return EncodeDecodeTypes.Mono_Alphabatic_Cipher;
//   }else{
//     return EncodeDecodeTypes.Rail_Fence_Cipher;
//   }
// }