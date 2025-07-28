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

  String railFenceCipher({required String cipherText, required int key}){
    if(key == 1){
      return cipherText;
    }
    List<List<String>> rail = [];

    // fill the list
    for(int i = 0 ; i < key; i++){
      List<String> temp = [];
      for(int j = 0; j < cipherText.length; j++){
        temp.add(" ");
      }
      rail.add(temp);
    }

    bool isDown = true;
    int row = 0, col = 0;
    for (int i = 0; i < cipherText.length; i++) {

      if (row == 0) { isDown = true; }
      if (row == key - 1) { isDown = false; }


      rail[row][col++] = '*';

      // find the next row using direction flag
      if (isDown) { row++; }
      else { row--; }
    }

    int ind = 0;
    for(int i = 0 ; i < key; i++){
      for(int j = 0; j < cipherText.length; j++){
        if(rail[i][j] == "*" && ind < cipherText.length){
          rail[i][j] = cipherText[ind++];
        }
      }
    }

  String ans = "";
    for (int i = 0; i < cipherText.length; i++) {
      if (row == 0) { isDown = true; }
      if (row == key - 1) { isDown = false; }

      ans += rail[row][col++];
      // find the next row using direction flag
      if (isDown) { row++; }
      else { row--; }
    }
    return ans;
  }
}
