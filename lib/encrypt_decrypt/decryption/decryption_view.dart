import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DecryptionView extends StatelessWidget{
  DecryptionController decryptionController = DecryptionController();
  EncryptionDecryptionOptionsController encryptionDecryptionOptionsController = Get.put(EncryptionDecryptionOptionsController(),tag: TAG_DECRYPT);
  DecryptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return commonScreenLayout(
      context: context,
      controller: decryptionController,
      methodsController: encryptionDecryptionOptionsController,
      titleText: "Enter Text to decrypt",
      isEncoding: false,
      isEncryption: true,
    );
  }
}