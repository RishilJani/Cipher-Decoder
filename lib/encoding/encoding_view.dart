import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class EncodingView extends StatelessWidget{
  EncodingController encodingController = EncodingController();
  KeyFieldController keyFieldController = Get.put(KeyFieldController());
  
  double height = 10;
  static const double fieldSpacing = 20.0;

  EncodingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_ENCODING),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //region Encoding
            myInputfield(
                context: context,
                textTitle: "Enter text to encode",
                hintText: 'enter text to cipher...',
                controller: encodingController.plainTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) { keyFieldController.onChange(controller: encodingController ); },
                optional: encodingController.cipherTextController,
                suffixIcon: pasteIconButton( controller: encodingController.plainTextController,  onChange: keyFieldController.onChange)
            ),
            SizedBox(height: height),
            // endregion

            EncodeDecodeOptions( controller: encodingController,),

            // region EncodedText
            myInputfield(
              context: context,
              controller: encodingController.cipherTextController,
              textTitle: "Encoded text:",
              hintText: "Encoded text...",
              readonly: true,
              suffixIcon: IconButton(
                onPressed: () {
                  copyText(encodingController.cipherTextController.text);
                },
                icon: const Icon(Icons.copy),
                tooltip: "Copy cipher text",
              ),
            ),
            const SizedBox(height: fieldSpacing * 1.5),
            // endregion

            // region Description
            Obx(
              () {
                return description(
                  context: context,
                  controller: keyFieldController,
                  selectedMethod: keyFieldController.selectedMethod.value,
                  text1: encodingController.plainTextController.text,
                  text2: encodingController.cipherTextController.text);
              }
            ),
            // endregion
          ],
        ),
      ),
    );
  }
}
