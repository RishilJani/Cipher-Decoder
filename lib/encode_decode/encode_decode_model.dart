import 'dart:convert';
import 'package:cipher_decoder/utils/import_export.dart';

abstract class EncodeDecodeModel{
  String? title;

  EncodeDecodeModel({this.title});

  String encode({required String plainText});

  String decode({required String encodedText});
}

class Base64 extends EncodeDecodeModel{
  Base64() : super(title: EN_BASE64);

  @override
  String encode({required String plainText}) {
    String encoded = base64Encode(utf8.encode(plainText));
    print(":::: base64 encoded = $encoded :::::::::::::::");

    return encoded;
  }

  @override
  String decode({required String encodedText}){
    String originalText = utf8.decode(base64Decode(encodedText));
    print(":::: base64 decode = $originalText :::::::::::::::");

    return originalText;
  }
}