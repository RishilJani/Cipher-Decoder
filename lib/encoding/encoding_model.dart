class EncodingModel {
  String? plaintText;

  EncodingModel({this.plaintText});

  String ceaserCipher(String plainText) {
    String cipherText = monoAlphabaticCipher(plainText: plainText, key: 3);
    return cipherText;
  }

  String atbashCipher(String plainText){
    String cipherText = plainText;
    return cipherText;
  }

  String monoAlphabaticCipher({required String plainText, required int key}){
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
    print("Cipher String ===== ${buffer.toString()}");
    return buffer.toString();
  }

}
