import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class EncryptionView extends StatelessWidget{
  EncryptionController encodingController = EncryptionController();
  EncryptionDecryptionOptionsController encodeDecodeOptionsController = Get.find<EncryptionDecryptionOptionsController>();

  double height = 10;
  static const double fieldSpacing = 20.0;

  EncryptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                  onChanged: (value) { encodeDecodeOptionsController.onChange(controller: encodingController ); },
                  optional: encodingController.cipherTextController,
                  suffixIcon: pasteIconButton( controller: encodingController.plainTextController,  onChange: encodeDecodeOptionsController.onChange)
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
                    controller: encodeDecodeOptionsController,
                  );
                }
              ),
              // endregion
            ],
          ),
        ),
      ),
    );
  }

}
