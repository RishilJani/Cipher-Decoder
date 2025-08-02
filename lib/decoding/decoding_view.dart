import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class DecodingView extends StatefulWidget {
  const DecodingView({super.key});

  @override
  State<DecodingView> createState() => _DecodingViewState();
}

class _DecodingViewState extends State<DecodingView> {
  DecodingController decodingController = DecodingController();
  KeyFieldController keyFieldController = KeyFieldController();
  // EncodeDecodeMethods _selectedMethod = encodeDecodeMethods[0];
  @override
  void initState() {
    super.initState();
    // _selectedMethod = encodeDecodeMethods[0];
  }


  String cipheredText = '';
  double height = 10;

  @override
  Widget build(BuildContext context) {

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
                controller: decodingController.cipherTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) { keyFieldController.onChange(controller: decodingController,isEncode: false); },
                optional: decodingController.plainTextController,
                suffixIcon: pasteIconButton(controller: decodingController.cipherTextController,onChange: keyFieldController.onChange,isEncode: false),
            ),
            // endregion

            SizedBox(height: height),

            EncodeDecodeOptions(controller: decodingController,),

            // region DecodedText
            myInputfield(
                context: context,
                controller: decodingController.plainTextController,
                textTitle: "Decoded text:",
                readonly: true,
                suffixIcon: IconButton(
                onPressed: () {
                  copyText(decodingController.plainTextController.text);
                },
                icon: const Icon(Icons.copy),
                tooltip: "Copy decoded text only",
              ),
            ),
            const SizedBox(height: fieldSpacing * 1.5),
            // endregion


            // region Description
            Obx(
                () => description(
                  context: context,
                  selectedMethod: keyFieldController.selectedMethod.value,
                  text1 : decodingController.cipherTextController.text,
                  text2 : decodingController.plainTextController.text
              ),
            ),

            // endregion
          ],
        ),
      ),
    );
  }

  void onDecodeChange({selectedMethod}){
    decodingController.decodeUsing( method: selectedMethod);

    // int? key = decodingController.keyController.text.isNotEmpty  ? int.parse(decodingController.keyController.text)  : null;
    setState(() {});
  }

}
