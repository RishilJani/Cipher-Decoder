import '../utils/import_export.dart';

abstract class EncodeDecodeMethods {
  String? title;
  String? description;
  bool requiresKey;
  int? key;

  EncodeDecodeMethods({this.title, this.description, this.requiresKey = false, this.key});

  String encode({required String plainText});

  String decode({required String cipherText });

  String explanation({required String text1 , required String text2});
  
}

class CeaseCipher extends EncodeDecodeMethods {
  CeaseCipher()  : super(title: EN_CEASER_CIPHER, description: CEASER_CIPHER_DESC);

  @override
  String encode({required String plainText}) {
    return MonoAlphabaticCipher(key: 3).encode(plainText: plainText);
  }

  @override
  String decode({required String cipherText}) {
    return MonoAlphabaticCipher(key:  3).decode(cipherText: cipherText);
  }

  @override
  String explanation({required String text1, required String text2}) {
    return dynamicDescription(text1: text1, text2: text2);
  }
}

class MonoAlphabaticCipher extends EncodeDecodeMethods {
  MonoAlphabaticCipher({required super.key}):super( title: EN_MONO_ALPHABATIC,  description: MONO_ALPHABATIC_CIPHER_DESC, requiresKey: true);

  @override
  String encode({required String plainText, int? optionalKey }) {
    optionalKey ??= key;

    if (optionalKey! % 26 == 0) {
      return plainText;
    }

    final shift = optionalKey % 26;
    final buffer = StringBuffer();

    for (var code in plainText.codeUnits) {
      if (code >= 65 && code <= 90) {
        // Uppercase A–Z
        buffer.writeCharCode(65 + (code - 65 + shift) % 26);
      } else if (code >= 97 && code <= 122) {
        // Lowercase a–z
        buffer.writeCharCode(97 + (code - 97 + shift) % 26);
      } else if (code >= '0'.codeUnitAt(0) && code <= '9'.codeUnitAt(0)) {
        buffer.writeCharCode(
            '0'.codeUnitAt(0) + (code - '0 '.codeUnitAt(0) + shift) % 10);
      } else {
        // Non-alphabetic
        buffer.writeCharCode(code);
      }
    }

    return buffer.toString();
  }

  @override
  String decode({required String cipherText, int? key}) {
    key ??=this.key;
    return encode(plainText: cipherText, optionalKey: 26 - (key! % 26));
  }

  @override
  String explanation({required String text1, required String text2}) {
    return dynamicDescription(text1: text1, text2: text2);
  }

}

class AtbashCipher extends EncodeDecodeMethods {
  AtbashCipher()
      : super(title: EN_ATBASH_CIPHER, description: ATBASH_CIPHER_DESC);

  @override
  String encode({required String plainText, int? key}) {
    StringBuffer cipherText = StringBuffer();

    for (var code in plainText.codeUnits) {
      if (code >= 65 && code <= 90) {
        cipherText.writeCharCode(90 - (code - 65));
      } else if (code >= 97 && code <= 122) {
        cipherText.writeCharCode(122 - (code - 97));
      } else {
        cipherText.writeCharCode(code);
      }
    }
    return cipherText.toString();
  }

  @override
  String decode({required String cipherText, int? key}) {
    return encode(plainText: cipherText);
  }

  @override
  String explanation({required String text1, required String text2}) {
    return dynamicDescription(text1: text1, text2: text2);
  }
}

class RailFenceCipher extends EncodeDecodeMethods {
  RailFenceCipher({required super.key}) : super(title: EN_RAIL_FENCE, description: RAIL_FENCE_DESC, requiresKey: true);

  @override
  String encode({required String plainText}) {
    if (key == 1) {
      return plainText;
    }

    int ind1 = 0;
    bool isDown = true;
    List<String> strs = [];
    for (int i = 0; i < key!; i++) {
      strs.add("");
    }
    for (int i = 0; i < plainText.length; i++) {
      strs[ind1] += plainText[i];

      if (isDown) {
        if (ind1 < key! - 1) {
          ind1++;
        } else {
          ind1--;
          isDown = false;
        }
      } else {
        if (ind1 > 0) {
          ind1--;
        } else {
          ind1++;
          isDown = true;
        }
      }
    }

    String ans = "";
    for (String str in strs) {
      ans = ans + str;
    }
    return ans;
  }

  @override
  String decode({required String cipherText}) {
    if (key == 1) {
      return cipherText;
    }
    List<List<String>> rail = [];

    // fill the list
    for (int i = 0; i < key!; i++) {
      List<String> temp = [];
      for (int j = 0; j < cipherText.length; j++) {
        temp.add(" ");
      }
      rail.add(temp);
    }

    bool isDown = true;
    int row = 0, col = 0;
    for (int i = 0; i < cipherText.length; i++) {
      if (row == 0) {
        isDown = true;
      }
      if (row == key! - 1) {
        isDown = false;
      }

      rail[row][col++] = '*';

      // find the next row using direction flag
      if (isDown) {
        row++;
      } else {
        row--;
      }
    }

    int ind = 0;
    for (int i = 0; i < key!; i++) {
      for (int j = 0; j < cipherText.length; j++) {
        if (rail[i][j] == "*" && ind < cipherText.length) {
          rail[i][j] = cipherText[ind++];
        }
      }
    }

    String ans = "";
    for (int i = 0; i < cipherText.length; i++) {
      if (row == 0) {
        isDown = true;
      }
      if (row == key! - 1) {
        isDown = false;
      }

      ans += rail[row][col++];
      // find the next row using direction flag
      if (isDown) {
        row++;
      } else {
        row--;
      }
    }
    return ans;
  }

  @override
  String explanation({required String text1, required String text2}) {
    return dynamicDescription(text1: text1, text2: text2);
  }
}
