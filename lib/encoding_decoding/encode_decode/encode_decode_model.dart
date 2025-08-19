import 'dart:convert';
import 'package:cipher_decoder/utils/import_export.dart';

abstract class EncodeDecodeModel{
  String? title;
  String? description;

  EncodeDecodeModel({this.title, this.description});

  String encode({required String plainText});

  String decode({required String encodedText});
}

class Base64 extends EncodeDecodeModel{
  Base64() : super(title: EN_BASE64,description: BASE64_DESC);

  @override
  String encode({required String plainText}) {
    String encoded = base64Encode(utf8.encode(plainText));
    print(":::: base64 encoded = $encoded :::::::::::::::");
    return encoded;
  }

  @override
  String decode({required String encodedText}){

    String originalText = '';
    try{
       originalText = utf8.decode(base64Decode(encodedText));
      print(":::: base64 decode = $originalText :::::::::::::::");
    }catch(e){
      print("HELLOOOOO0000 ERROR:::::::::::::;;");
      originalText = encodedText;
    }

    return originalText;
  }
}

// class Base32 extends EncodeDecodeModel{
//   Base32() : super(title: EN_BASE32,description: BASE32_DESC);
//
// }