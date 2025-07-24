import 'package:cipher_decoder/utils/import_export.dart';

class DecodingModel{
  EncodingModel encodingModel = EncodingModel();
  String ceaserCipher(String cipherText){
    return encodingModel.ceaserCipher(cipherText,key: 23);
  }

  String atbashCipher(String cipherText){
    return encodingModel.atbashCipher(cipherText);
  }

  String monoAlphabaticCipher({required String cipherText, required int key}){
    return encodingModel.monoAlphabaticCipher(plainText: cipherText, key: key);
  }
}