import 'package:cipher_decoder/utils/import_export.dart';

abstract class EncryptionDecryptionModel {
  String? title;
  String? description;
  bool requiresKey;
  TextEditingController? keyController;

  EncryptionDecryptionModel({this.title, this.description, this.requiresKey = false, this.keyController = null});

  String encrypt({required String plainText});

  String decrypt({required String cipherText });

}
//
// class CeaseCipher extends EncryptionDecryptionModel {
//   CeaseCipher()  : super(title: EN_CEASER_CIPHER, description: CEASER_CIPHER_DESC);
//
//   @override
//   String encrypt({required String plainText}) {
//     return MonoAlphabaticCipher().encrypt(plainText: plainText, optionalKey: 3);
//   }
//
//   @override
//   String decrypt({required String cipherText}) {
//     return MonoAlphabaticCipher().decrypt(cipherText: cipherText, key: 3);
//   }
//
// }

class CeaseCipher extends EncryptionDecryptionModel {
  CeaseCipher():super( title: EN_CEASER_CIPHER,  description: CEASER_CIPHER_DESC, requiresKey: true, keyController: new TextEditingController(text: "3"));

  @override
  String encrypt({required String plainText, int? optionalKey }) {
    int k = keyController!.text.isEmpty ? 0 : int.parse(keyController!.text);
    optionalKey ??= k;

    if (optionalKey % 26 == 0) {
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
  String decrypt({required String cipherText, int? key}) {
    key ??= keyController!.text.isEmpty ? 0 : int.parse(keyController!.text);
    return encrypt(plainText: cipherText, optionalKey: 26 - (key % 26));
  }

}

class AtbashCipher extends EncryptionDecryptionModel {
  AtbashCipher()
      : super(title: EN_ATBASH_CIPHER, description: ATBASH_CIPHER_DESC);

  @override
  String encrypt({required String plainText, int? key}) {
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
  String decrypt({required String cipherText, int? key}) {
    return encrypt(plainText: cipherText);
  }

}

class RailFenceCipher extends EncryptionDecryptionModel {
  RailFenceCipher() : super(title: EN_RAIL_FENCE, description: RAIL_FENCE_DESC, requiresKey: true, keyController: new TextEditingController());

  @override
  String encrypt({required String plainText}) {
    int k = keyController!.text.isEmpty ?  1 : int.parse(keyController!.text);
    if (k == 1 || k == 0) {
      return plainText;
    }

    int ind1 = 0;
    bool isDown = true;
    List<String> strs = [];
    for (int i = 0; i < k; i++) {
      strs.add("");
    }
    for (int i = 0; i < plainText.length; i++) {
      strs[ind1] += plainText[i];

      if (isDown) {
        if (ind1 < k - 1) {
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
  String decrypt({required String cipherText}) {
    int k = keyController!.text.isEmpty ? 0 : int.parse(keyController!.text);
    if (k == 1) {
      return cipherText;
    }
    List<List<String>> rail = [];

    // fill the list
    for (int i = 0; i < k; i++) {
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
      if (row == k - 1) {
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
    for (int i = 0; i < k; i++) {
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
      if (row == k - 1) {
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

}
