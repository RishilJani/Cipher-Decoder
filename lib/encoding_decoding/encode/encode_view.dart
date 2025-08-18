import 'package:cipher_decoder/utils/import_export.dart';

class EncodeView extends StatelessWidget {
  const EncodeView({super.key});

  @override
  Widget build(BuildContext context) {
    EncodeController encodeController = EncodeController();
    EncodeDecodeOptionController encodeDecodeOptionController = Get.put(EncodeDecodeOptionController() , tag: TAG_ENCODE);

    return myScreen(
      context: context,
      controller: encodeController,
      methodsController: encodeDecodeOptionController,
      titleText: "Enter text to encode",
      isEncoding: true,
      isEncryption: false
    );
  }
}
