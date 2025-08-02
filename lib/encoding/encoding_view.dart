import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class EncodingView extends StatefulWidget {
  const EncodingView({super.key});

  @override
  State<EncodingView> createState() => _EncodingViewState();
}

class _EncodingViewState extends State<EncodingView> {
  EncodingController encodingController = EncodingController();
  EncodeDecodeMethods _selectedMethod = encodeDecodeMethods[0];
  bool showConditionalField = false;

  @override
  void initState() {
    super.initState();
    _selectedMethod = encodeDecodeMethods[0];
    showConditionalField = _selectedMethod.requiresKey;
  }

  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController();
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
                controller: plainTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) {
                  setState(() {
                    onEncodeChange();
                  });
                },
                optional: cipherTextController,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    pasteIconButton(
                        controller: plainTextController,
                        onChange: onEncodeChange),
                  ],
                )),
            SizedBox(height: height),
            // endregion

            dropdownKeyField(
                context: context,
                onChange: onEncodeChange,
                selectedMethod: _selectedMethod,
                keyController: keyController,
                showConditionalField: showConditionalField
            ),

            // region EncodedText
            myInputfield(
              context: context,
              controller: cipherTextController,
              textTitle: "Encoded text:",
              readonly: true,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      copyText(cipherTextController.text);
                    },
                    icon: const Icon(Icons.copy),
                    tooltip: "Copy cipher text only",
                  ),
                  // clearIconButton(controller: cipherTextController, text: "Clear Cipher text"),
                ],
              ),
            ),
            const SizedBox(height: fieldSpacing * 1.5),
            // endregion

            // region Description
            description(
                context: context,
                selectedMethod: _selectedMethod,
                text1: plainTextController.text,
                text2: cipherTextController.text),
            // endregion
          ],
        ),
      ),
    );
  }

  void onEncodeChange({selectedMethod}) {
    int? key =
        keyController.text.isNotEmpty ? int.parse(keyController.text) : null;
    cipherTextController.text = encodingController.encodeUsing(
        plainText: plainTextController.text, method: selectedMethod, key: key);
    showConditionalField = selectedMethod.requiresKey;
    setState(() {});
  }
}
