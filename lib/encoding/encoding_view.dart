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
     showConditionalField = keyConditionalField(_selectedMethod);
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
                    pasteIconButton(controller: plainTextController,onChange: onEncodeChange),
                  ],
                )
            ),
              SizedBox(height: height),
            // endregion

            dropdownKeyField(context: context),

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
                text1 : plainTextController.text,
                text2 : cipherTextController.text
            ),
            // endregion
          ],
        ),
      ),
    );
  }

  void onEncodeChange(){
    int? key = keyController.text.isNotEmpty
        ? int.parse(keyController.text)
        : null;
    cipherTextController.text = encodingController.encodeUsing(
        plainText: plainTextController.text,
        method: _selectedMethod,
        key: key);
    showConditionalField = keyConditionalField(_selectedMethod);
    setState(() {});
  }


  Widget dropdownKeyField({context}){
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // region Dropdown
        Text(
          'Select method to encode:',
          style:
          textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 12.0),
          ),
          style: textTheme.bodyMedium,
          icon:  Icon(Icons.arrow_drop_down_circle_sharp, color: theme.primaryColor, size: 28,),
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
              onEncodeChange();
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
              ? myInputfield(
              key: const ValueKey('conditionalField'),
              context: context,
              textTitle: 'Enter Key:',
              hintText: 'Enter Integer Key...',
              controller: keyController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  onEncodeChange();
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
              suffixIcon: clearIconButton(controller: keyController,text: "Clear Key")
          )
              : const SizedBox.shrink(
              key: ValueKey(
                  'emptyConditional')), // Use SizedBox.shrink when hidden
        ),
        // endregion

        // region AdjustSpace
        if (!showConditionalField)
          const SizedBox(height:  fieldSpacing * 1.5), // Adjust spacing if field is hidden
        // endregion
      ],
    );
  }
}
