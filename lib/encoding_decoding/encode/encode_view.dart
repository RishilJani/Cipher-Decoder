import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class EncodeView extends StatelessWidget {
  EncodeController encodeController = EncodeController();
  EncodeDecodeOptionController encodeDecodeOptionController = Get.put(EncodeDecodeOptionController() , tag: TAG_ENCODE);
  EncodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return modernScreenLayout(
      context: context,
      controller: encodeController,
      methodsController: encodeDecodeOptionController,
      titleText: "Enter text to encode",
      isEncoding: true,
      isEncryption: false,
    );
  }
}
