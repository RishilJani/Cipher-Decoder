import 'dart:convert';
import 'package:cipher_decoder/utils/import_export.dart';

abstract class EncodeDecodeModel{
  String? title;
  String? description;
  RegExp? validRegexp;

  EncodeDecodeModel({this.title, this.description, this.validRegexp});

  String encode({required String plainText});

  String decode({required String encodedText});
}

class Base64 extends EncodeDecodeModel{
  Base64() : super(title: EN_BASE64,description: BASE64_DESC, validRegexp: base64RegExp);

  @override
  String encode({required String plainText}) {
    String encoded = base64Encode(utf8.encode(plainText));
    return encoded;
  }

  @override
  String decode({required String encodedText}){

    String originalText = '';

    originalText = utf8.decode(base64Decode(encodedText));
    return originalText;
  }
}


class Base32 extends EncodeDecodeModel{
  Base32() : super(title: EN_BASE32,description: BASE32_DESC, validRegexp: base32RegExp);
  final _base32Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

  @override
  String encode({required String plainText}) {
    var bytes = utf8.encode(plainText);
    var output = StringBuffer();
    int current = 0, bits = 0;

    for (var b in bytes) {
      current = (current << 8) | b;
      bits += 8;
      while (bits >= 5) {
        output.write(_base32Chars[(current >> (bits - 5)) & 31]);
        bits -= 5;
      }
    }

    if (bits > 0) {
      output.write(_base32Chars[(current << (5 - bits)) & 31]);
    }

    // Padding (RFC 4648)
    while (output.length % 8 != 0) {
      output.write('=');
    }
    return output.toString();
  }

  @override
  String decode({required String encodedText}) {
    encodedText = encodedText.replaceAll('=', ''); // remove padding
    int current = 0, bits = 0;
    List<int> bytes = [];

    for (var c in encodedText.split('')) {
      int val = _base32Chars.indexOf(c);
      if (val < 0) continue;
      current = (current << 5) | val;
      bits += 5;

      if (bits >= 8) {
        bytes.add((current >> (bits - 8)) & 0xFF);
        bits -= 8;
      }
    }

    return utf8.decode(bytes);
  }
}