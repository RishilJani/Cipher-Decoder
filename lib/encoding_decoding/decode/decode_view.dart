import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DecodeView extends StatelessWidget {
  const DecodeView({super.key});

  @override
  Widget build(BuildContext context) {
    DecodeController decodeController = DecodeController();
    EncodeDecodeOptionController encodeDecodeOptionController = Get.put(EncodeDecodeOptionController() , tag: TAG_DECODE);

    return myScreen(
      context: context,
      controller: decodeController,
      methodsController: encodeDecodeOptionController,
      titleText: "Enter text to decode",
      isEncoding: false,
      isEncryption: false,
    );
  }
}
