import 'package:cipher_decoder/utils/import_export.dart';

class ControllerTypeException implements Exception{
  String? message ;

  ControllerTypeException({required this.message});

  @override
  String toString() {
    return message!;
  }
}

class DecodeStringSizeException implements Exception{
  String? message;

  DecodeStringSizeException({this.message = DECODE_LENGTH_ERROR});

  @override
  String toString() {
    return message!;
  }
}