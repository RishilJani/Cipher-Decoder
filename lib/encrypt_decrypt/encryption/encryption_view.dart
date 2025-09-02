import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class EncryptionView extends StatelessWidget{
  EncryptionController encryptionController = EncryptionController();
  EncryptionDecryptionOptionsController encryptionDecryptionOptionsController = Get.put(EncryptionDecryptionOptionsController(),tag: TAG_ENCRYPT);
  EncryptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return modernScreenLayout(
      context: context,
      controller: encryptionController,
      methodsController: encryptionDecryptionOptionsController,
      titleText: "Enter Text to encrypt",
      isEncoding: true,
      isEncryption: true,
    );
  }

}
