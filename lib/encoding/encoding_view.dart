import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class EncodingView extends StatefulWidget {
  const EncodingView({super.key});

  @override
  State<EncodingView> createState() => _EncodingViewState();
}

class _EncodingViewState extends State<EncodingView> {
  EncodingController encodingController = EncodingController();
  String _selectedMethod = '';

  @override
  void initState() {
    super.initState();
    _selectedMethod = encodeDecodeMethods[0];
  }

  TextEditingController plainTextController = TextEditingController();
  TextEditingController cipherTextController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  double height = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    bool showConditionalField = keyRequired.contains(_selectedMethod);
    const double fieldSpacing = 20.0;
    
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_ENCODING),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //region encoding
            myInputfield(
                context: context,
                textTitle: "Enter text to encode",
                hintText: 'enter text to cipher...',
                controller: plainTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    int? key = keyController.text.isNotEmpty
                        ? int.parse(keyController.text)
                        : null;
                    cipherTextController.text = encodingController.encodeUsing(
                        plainText: plainTextController.text,
                        method: _selectedMethod,
                        key: key);
                  });
                }),
            // endregion

            SizedBox(height: height),

            // drop down
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
              style: textTheme.bodyLarge,
              icon:
                  Icon(Icons.arrow_drop_down_circle, color: theme.primaryColor),
              isExpanded: true,
              value: _selectedMethod,
              items: encodeDecodeMethods.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                });
              },
            ),

            // animated switch
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
                          int? key = keyController.text.isNotEmpty
                              ? int.parse(keyController.text)
                              : null;
                          cipherTextController.text =
                              encodingController.encodeUsing(
                                  plainText: plainTextController.text,
                                  method: _selectedMethod,
                                  key: key);
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
                      key: ValueKey(
                          'emptyConditional')), // Use SizedBox.shrink when hidden
            ),

            // style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            if (!showConditionalField)
              const SizedBox(
                  height:
                      fieldSpacing * 1.5), // Adjust spacing if field is hidden

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
                    IconButton(
                      onPressed: () {
                        copyText(
                            "${plainTextController.text} \n\n${cipherTextController.text}");
                      },
                      icon: const Icon(Icons.copy_all),
                      tooltip: "Copy normal and cipher text",
                    ),
                  ],
                )),
            const SizedBox(height: fieldSpacing * 1.5),
          ],
        ),
      ),
    );
  }

}
