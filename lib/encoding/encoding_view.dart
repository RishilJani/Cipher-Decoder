import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class EncodingView extends StatefulWidget {
  const EncodingView({super.key});

  @override
  State<EncodingView> createState() => _EncodingViewState();
}

class _EncodingViewState extends State<EncodingView> {
  EncodingController encodingController = EncodingController();
  KeyFieldController keyFieldController = KeyFieldController();

  @override
  void initState() {
    super.initState();
  }

  double height = 10;
  static const double fieldSpacing = 20.0;

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
                onChanged: (value) { keyFieldController.onChange(controller: encodingController,isEncode: true); },
                optional: encodingController.cipherTextController,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [ pasteIconButton(
                        controller: encodingController.plainTextController,
                        onChange: keyFieldController.onChange,
                        isEncode: true
                      ),
                  ],
                )
            ),
            SizedBox(height: height),
            // endregion

            EncodeDecodeOptions(controller: encodingController,),

            // region EncodedText
            myInputfield(
                context: context,
                controller: encodingController.cipherTextController,
                textTitle: "Encoded text:",
                readonly: true,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        copyText(encodingController.cipherTextController.text);
                      },
                      icon: const Icon(Icons.copy),
                      tooltip: "Copy cipher text",
                    ),
                    // clearIconButton(controller: cipherTextController, text: "Clear Cipher text"),
                  ],
                ),
              ),
            const SizedBox(height: fieldSpacing * 1.5),
            // endregion

            // region Description
            Obx(() {
              print("OBX CALLED:::::");
              return description(
                    context: context,
                    selectedMethod: keyFieldController.selectedMethod.value,
                    text1: encodingController.plainTextController.text,
                    text2: encodingController.cipherTextController.text);
              }
            )

            // endregion
          ],
        ),
      ),
    );
  }

  void onEncodeChange({selectedMethod}) {
    encodingController.encodeUsing( method: selectedMethod);

    // int? key = encodingController.keyController.text.isNotEmpty ? int.parse(encodingController.keyController.text) : null;
    setState(() {});
  }
}
