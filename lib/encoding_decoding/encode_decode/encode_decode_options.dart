import 'package:cipher_decoder/utils/import_export.dart';
// ignore:must_be_immutable
class EncodeDecodeOptions extends StatelessWidget{
  EncodeDecodeOptions({super.key, required this.controller, this.index, required this.encodeDecodeOptionController}){
    txt = 'Select method to ${controller is EncodeController ? 'encode' : 'decode'}';
  }

  final dynamic controller;
  int? index;
  EncodeDecodeOptionController encodeDecodeOptionController;
  String txt = '';

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}