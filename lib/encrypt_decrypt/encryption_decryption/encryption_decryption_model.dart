import 'package:cipher_decoder/utils/import_export.dart';

abstract class EncryptionDecryptionModel {
  String? title;
  String? description;
  bool requiresKey;
  TextEditingController? keyController;

  EncryptionDecryptionModel(
      {this.title,
      this.description,
      this.requiresKey = false,
      this.keyController = null});

  String encrypt({required String plainText});

  String decrypt({required String cipherText});
}

class CeaseCipher extends EncryptionDecryptionModel {
  CeaseCipher()
      : super(
            title: EN_CEASER_CIPHER,
            description: CEASER_CIPHER_DESC,
            requiresKey: true,
            keyController: new TextEditingController(text: "3"));

  @override
  String encrypt({required String plainText, int? optionalKey}) {
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
  RailFenceCipher()
      : super(
            title: EN_RAIL_FENCE,
            description: RAIL_FENCE_DESC,
            requiresKey: true,
            keyController: new TextEditingController());

  @override
  String encrypt({required String plainText}) {
    int k = keyController!.text.isEmpty ? 1 : int.parse(keyController!.text);
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

class PlayFairCipher extends EncryptionDecryptionModel {
  PlayFairCipher()
      : super(
            title: EN_PLAY_FAIR,
            description: PLAY_FAIR_DESC,
            requiresKey: true,
            keyController: new TextEditingController());

  @override
  String decrypt({required String cipherText}) {
    cipherText = cipherText.replaceAll(" ", "");
    String plainText = "";
    List<List<String>> table = _generateTable(keyController!.text.toString());
    if (table.isEmpty) {
      return "";
    }
    String c1, c2;
    List<int> ind1, ind2;
    int temp;
    for (int i = 0; i < cipherText.length; i += 2) {
      c1 = cipherText[i];
      if (i + 1 < cipherText.length)
        c2 = cipherText[i + 1];
      else
        c2 = 'X';

      ind1 = _getIndex(table, c1);
      ind2 = _getIndex(table, c2);

      if (ind1[0] == ind2[0]) {
        // same row
        temp = (ind1[1] - 1 + 5) % 5;
        plainText += table[ind1[0]][temp];
        temp = (ind2[1] - 1 + 5) % 5;

        plainText += table[ind2[0]][temp];
      } else if (ind1[1] == ind2[1]) {
        // same col
        temp = (ind1[0] - 1 + 5) % 5;
        plainText += table[temp][ind1[1]];
        temp = (ind2[0] - 1 + 5) % 5;
        plainText += table[temp][ind1[1]];
      } else {
        plainText += table[ind1[0]][ind2[1]];
        plainText += table[ind2[0]][ind1[1]];
      }
    }
    return plainText.toString();
  }

  @override
  String encrypt({required String plainText}) {
    plainText = plainText.removeAllWhitespace.toUpperCase();
    List<List<String>> table = _generateTable(keyController!.text.toString());
    if (table.isEmpty) {
      return "";
    }
    String cipher = "";
    String c1, c2;
    List<int> ind1, ind2;
    int temp;
    for (int i = 0; i < plainText.length; i += 2) {
      c1 = plainText[i];
      if (i + 1 < plainText.length)
        c2 = plainText[i + 1];
      else
        c2 = 'X';
      if (c1 == c2) {
        if (c1 == 'X')
          c2 = 'Z';
        else
          c2 = 'X';
        i--;
      }
      ind1 = _getIndex(table, c1);
      ind2 = _getIndex(table, c2);

      if (ind1[0] == ind2[0]) {
        // same row
        temp = (ind1[1] + 1) % 5;
        cipher += table[ind1[0]][temp];

        temp = (ind2[1] + 1) % 5;
        cipher += table[ind2[0]][temp];
      } else if (ind1[1] == ind2[1]) {
        // same col
        temp = (ind1[0] + 1) % 5;
        cipher += table[temp][ind1[1]];
        temp = (ind2[0] + 1) % 5;
        cipher += table[temp][ind1[1]];
      } else {
        cipher += table[ind1[0]][ind2[1]];
        cipher += table[ind2[0]][ind1[1]];
      }
    }
    return cipher;
  }

  List<List<String>> _generateTable(String key) {
    if (key.isEmpty) {
      return [];
    }
    key = key.toUpperCase();
    List<List<String>> table = [];
    Set<String> s = {};
    String alpha = 'A', c = ' ';
    int ind = 0;
    for (int i = 0; i < 5; i++) {
      List<String> tl = [];
      for (int j = 0; j < 5; j++) {
        if (ind < key.length) {
          c = key[ind];
          while (ind < key.length && s.contains(c)) {
            c = key[ind++];
            if (c == 'J') c = 'I';
          }
          if (ind == key.length) c = alpha;
        } else {
          c = alpha;
          while (c.compareTo("Z") <= 0 && s.contains(c)) {
            if (alpha == 'J') alpha = _getNextChar(alpha);
            c = alpha;
            alpha = _getNextChar(alpha);
          }
        }
        tl.add(c);
        s.add(c);
      }
      table.add(tl);
    }
    return table;
  }

  String _getNextChar(String a) {
    return String.fromCharCode(a.codeUnits[0] + 1);
  }

  List<int> _getIndex(List<List<String>> table, String c) {
    List<int> index = [-1, -1];

    for (int i = 0; i < table.length; i++) {
      for (int j = 0; j < table.length; j++) {
        if (table[i][j] == c) {
          index[0] = i;
          index[1] = j;
        } else if (c == 'J' && table[i][j] == 'I') {
          index[0] = i;
          index[1] = j;
        }
      }
    }
    return index;
  }
}
