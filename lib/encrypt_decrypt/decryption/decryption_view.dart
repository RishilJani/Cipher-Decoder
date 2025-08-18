import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DecryptionView extends StatelessWidget{
  DecryptionController decryptionController = DecryptionController();
  EncryptionDecryptionOptionsController encryptionDecryptionOptionsController = Get.put(EncryptionDecryptionOptionsController(),tag: TAG_DECRYPT);

  double height = 10;
  static const double fieldSpacing = 20.0;

  DecryptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return myScreen(
      context: context,
      controller: decryptionController,
      methodsController: encryptionDecryptionOptionsController,
      titleText: "Enter Text to decrypt",
      isEncoding: false
    );
  }
}
/*
Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //region decoding
              myInputfield(
                context: context,
                textTitle: "Enter text to decrypt",
                hintText: 'enter text to decipher...',
                controller: decodingController.cipherTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) { encodeDecodeOptionsController.onChange(controller: decodingController); },
                optional: decodingController.plainTextController,
                suffixIcon: pasteIconButton(controller: decodingController.cipherTextController,onChange: encodeDecodeOptionsController.onChange),
              ),
              SizedBox(height: height),
              // endregion

              getOptionList(controller: decodingController),

              addOptionButton(controller: decodingController),

              const SizedBox(height: fieldSpacing),

              // region DecryptedText
              myInputfield(
                context: context,
                controller: decodingController.plainTextController,
                textTitle: "Decrypted text:",
                hintText: "Decrypted text...",
                readonly: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    copyText(decodingController.plainTextController.text);
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: "Copy decrypted text",
                ),
              ),
              const SizedBox(height: fieldSpacing * 1.5),
              // endregion

              // region Description
              Obx(() {
                return description(
                    context: context,
                    controller: encodeDecodeOptionsController,
                );
              }),
              // endregion
            ],
          ),
        ),
      ),
    );
 */