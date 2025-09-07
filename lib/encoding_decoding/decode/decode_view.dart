import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DecodeView extends StatelessWidget {
  DecodeController decodeController = DecodeController();
  // EncodeDecodeOptionController encodeDecodeOptionController = Get.put(EncodeDecodeOptionController() , tag: TAG_DECODE);
  EncodeDecodeOptionController encodeDecodeOptionController = EncodeDecodeOptionController();
  DecodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return modernScreenLayout(
      context: context,
      controller: decodeController,
      methodsController: encodeDecodeOptionController,
      titleText: "Enter text to decode",
      isEncoding: false,
      isEncryption: false,
    );
  }
}
