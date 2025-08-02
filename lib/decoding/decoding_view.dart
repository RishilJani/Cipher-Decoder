import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class DecodingView extends StatefulWidget {
  const DecodingView({super.key});

  @override
  State<DecodingView> createState() => _DecodingViewState();
}

class _DecodingViewState extends State<DecodingView> {
  DecodingController decodingController = DecodingController();
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

  String cipheredText = '';
  double height = 10;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final textTheme = theme.textTheme;

    // Define consistent spacing
    const double fieldSpacing = 20.0;
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_DECODING),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //region decoding
            myInputfield(
                context: context,
                textTitle: "Enter text to decode",
                hintText: 'enter text to decipher...',
                controller: cipherTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) {
                  setState(() {
                    onDecodeChange();
                  });
                },
                optional: plainTextController,
                suffixIcon: pasteIconButton(controller: cipherTextController,onChange: onDecodeChange),
            ),
            // endregion

            SizedBox(height: height),

            dropdownKeyField(
                context: context,
                onChange: onDecodeChange,
                selectedMethod: _selectedMethod,
                keyController: keyController,
                showConditionalField: showConditionalField
            ),


            // region DecodedText
            myInputfield(
                context: context,
                controller: plainTextController,
                textTitle: "Decoded text:",
                readonly: true,
                suffixIcon: IconButton(
                onPressed: () {
                  copyText(plainTextController.text);
                },
                icon: const Icon(Icons.copy),
                tooltip: "Copy decoded text only",
              ),
            ),
            const SizedBox(height: fieldSpacing * 1.5),
            // endregion


            // region Description
            description(
                context: context,
                selectedMethod: _selectedMethod,
                text1 : cipherTextController.text,
                text2 : plainTextController.text
            ),

            // endregion
          ],
        ),
      ),
    );
  }

  void onDecodeChange({selectedMethod}){
    int? key = keyController.text.isNotEmpty
        ? int.parse(keyController.text)
        : null;
    plainTextController.text = decodingController.decodeUsing(
        cipherText: cipherTextController.text,
        method: selectedMethod,
        key: key);
    showConditionalField = selectedMethod.requiresKey;
    setState(() {});
  }

}
