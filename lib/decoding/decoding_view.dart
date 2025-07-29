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
    showConditionalField = keyConditionalField(_selectedMethod);
  }

  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  String cipheredText = '';
  double height = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                    onDecodeChanged();
                  });
                },
                optional: plainTextController,
                suffixIcon: pasteIconButton(controller: cipherTextController,onChange: onDecodeChanged),
            ),
            // endregion

            SizedBox(height: height),

            // region Dropdown
            Text(
              'Select method to decode:',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              style: textTheme.bodyMedium,
              icon: Icon(Icons.arrow_drop_down_circle, color: theme.primaryColor),
              isExpanded: true,
              value: _selectedMethod,
              items: encodeDecodeMethods.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.title!),
                );
              },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                  onDecodeChanged();
                });
              },
            ),

            // endregion


            // region AnimatedSwitch

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: showConditionalField
                  ?  myInputfield(
                key: const ValueKey('conditionalField'),
                context: context,
                textTitle: 'Enter Key:',
                hintText: 'Enter Integer Key...',
                controller: keyController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    onDecodeChanged();
                  });
                },
                validator: (value) {
                  // Only validate if the field is visible and supposed to be filled
                  if (showConditionalField &&
                      (value == null || value.isEmpty)) {
                    return 'This field is required is selected.';
                  }
                  return null;
                },
              )
                  : const SizedBox.shrink(
                  key: ValueKey( 'emptyConditional')), // Use SizedBox.shrink when hidden
            ),
            // endregion

            if (!showConditionalField)
              const SizedBox(
                  height:
                  fieldSpacing * 1.5), // Adjust spacing if field is hidden

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

  void onDecodeChanged(){
    int? key = keyController.text.isNotEmpty
        ? int.parse(keyController.text)
        : null;
    plainTextController.text = decodingController.decodeUsing(
        cipherText: cipherTextController.text,
        method: _selectedMethod,
        key: key);
    showConditionalField = keyConditionalField(_selectedMethod);
    setState(() {});
  }

}
