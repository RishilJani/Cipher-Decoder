class EncodingModel {

  String ceaserCipher(String plainText,{int? key = 3}) {
    String cipherText = monoAlphabaticCipher(plainText: plainText, key: key!);
    return cipherText;
  }

  String atbashCipher(String plainText){
    StringBuffer cipherText = StringBuffer();

    for(var code in plainText.codeUnits){
      if(code >= 65 && code <= 90){
        cipherText.writeCharCode(90 - (code - 65));
      }else if(code >= 97 && code <= 122){
        cipherText.writeCharCode(122 - (code - 97));
      }else{
        cipherText.writeCharCode(code);
      }
    }
    return cipherText.toString();
  }

  String monoAlphabaticCipher({required String plainText, required int key}){
    if(key % 26 == 0){
      return plainText;
    }
    final shift = key % 26;
    final buffer = StringBuffer();

    for (var code in plainText.codeUnits) {
      if (code >= 65 && code <= 90) {
        // Uppercase A–Z
        buffer.writeCharCode(65 + (code - 65 + shift) % 26);
      } else if (code >= 97 && code <= 122) {
        // Lowercase a–z
        buffer.writeCharCode(97 + (code - 97 + shift) % 26);
      } else if(code >= '0'.codeUnitAt(0) && code <= '9'.codeUnitAt(0)){
        buffer.writeCharCode('0'.codeUnitAt(0) + (code - '0 '.codeUnitAt(0) + shift) % 10);
      }else{
        // Non-alphabetic
        buffer.writeCharCode(code);
      }
    }
    return buffer.toString();
  }

  String railFence({required String plainText,required int key}){
    if(key == 1){
      return plainText;
    }

    int ind1 = 0;
    bool isDown = true;
    List<String> strs = [];
    for(int i = 0 ; i < key;i++){
      strs.add("");
    }
    for (int i = 0; i < plainText.length; i++) {
      strs[ind1] += plainText[i];

      if(isDown){
        if(ind1 < key-1){ ind1++;}
        else{ ind1--; isDown = false;}
      }else{
        if(ind1 > 0){ ind1--; }
        else{ ind1++; isDown = true; }
      }
    }

    String ans = "";
    for (String str in strs) {
      ans = ans + str;
    }
    return ans;
  }
}
