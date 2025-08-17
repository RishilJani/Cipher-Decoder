import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class EncryptionView extends StatelessWidget{
  EncryptionController encryptionController = EncryptionController();
  EncryptionDecryptionOptionsController encryptionDecryptionOptionsController = Get.put(EncryptionDecryptionOptionsController());

  double height = 10;
  static const double fieldSpacing = 20.0;

  EncryptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return myScreen(
      context: context,
      controller: encryptionController,
      methodsController: encryptionDecryptionOptionsController,
      titleText: "Enter Text to encrypt",
      isEncoding: true,
    );
  }

}
/*
GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //region Encryption
              myInputfield(
                  context: context,
                  textTitle: "Enter text to encrypt",
                  hintText: 'enter text to cipher...',
                  controller: encodingController.plainTextController,
                  minLines: 3,
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) { encryptionDecryptionOptionsController.onChange(controller: encodingController ); },
                  optional: encodingController.cipherTextController,
                  suffixIcon: pasteIconButton( controller: encodingController.plainTextController,  onChange: encryptionDecryptionOptionsController.onChange)
              ),
              SizedBox(height: height),
              // endregion

              getOptionList(controller: encodingController),

              addOptionButton(controller: encodingController),

              const SizedBox(height: fieldSpacing),

              // region Encrypted
              myInputfield(
                context: context,
                controller: encodingController.cipherTextController,
                textTitle: "Encrypted text:",
                hintText: "Encrypted text...",
                readonly: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    copyText(encodingController.cipherTextController.text);
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: "Copy encrypted text",
                ),
              ),
              const SizedBox(height: fieldSpacing * 1.5),
              // endregion

              // region Description
              Obx(
                () {
                  return description(
                    context: context,
                    controller: encryptionDecryptionOptionsController,
                  );
                }
              ),
              // endregion
            ],
          ),
        ),
      )
 */
