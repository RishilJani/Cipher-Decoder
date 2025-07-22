import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class DecodingView extends StatefulWidget {
  const DecodingView({super.key});

  @override
  State<DecodingView> createState() => _DecodingViewState();
}

class _DecodingViewState extends State<DecodingView> {
  EncodingController encodingController = EncodingController();

  String _selectedMethod = '';

  @override
  void initState() {

    super.initState();
    _selectedMethod = encodingController.encodingList[0];
  }
  TextEditingController plainTextController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  String cipheredText = '';
  double height = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    bool showConditionalField = encodingController.keyRequired.contains(_selectedMethod);
    // Define consistent spacing
    const double fieldSpacing = 20.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(APPBAR_TITLE_DECODING),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your notes:',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: plainTextController,
              decoration: InputDecoration(
                hintText: 'enter text to decipher...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              style: textTheme.bodyLarge,
              minLines: 3,
              maxLines: 7,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              onChanged:(value) {
                setState(() {
                  int? key = keyController.text.isNotEmpty ? int.parse(keyController.text) : null;
                  print("keyyyyyyyyyyyyyy ========= $key");
                  print("method ========= $_selectedMethod");
                  cipheredText = encodingController.encodeUsing(plainText: plainTextController.text, method: _selectedMethod, key: key);
                });
              },
            ),
            SizedBox(height: height),

            // drop down
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
              style: textTheme.bodyLarge,
              icon: Icon(Icons.arrow_drop_down_circle, color: theme.primaryColor),
              isExpanded: true,
              value: _selectedMethod,
              items: encodingController.encodingList.map((e) {
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
                  ? Column(
                // Use a Column to group the label and field
                key: const ValueKey(
                    'conditionalField'), // Important for AnimatedSwitcher
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Key:',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),

                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Type additional information here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    controller: keyController,
                    validator: (value) {
                      // Only validate if the field is visible and supposed to be filled
                      if (showConditionalField &&
                          (value == null || value.isEmpty)) {
                        return 'This field is required is selected.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(
                      height: fieldSpacing *
                          1.5), // Extra spacing after conditional field
                ],
              )
                  : const SizedBox.shrink(
                  key: ValueKey(
                      'emptyConditional')), // Use SizedBox.shrink when hidden
            ),

            if (!showConditionalField)
              const SizedBox(
                  height:
                  fieldSpacing * 1.5), // Adjust spacing if field is hidden

            // TextFormField(
            //   controller: cipherTextController,
            //   minLines: 3,
            //   maxLines: 7,
            //   decoration: InputDecoration(
            //       hintText: "Encrypted text....",
            //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
            //   ),
            //   onChanged: (value) {
            //     // print("Printing ::: $value");
            //   },
            // ),

            Container(
              width: double.infinity, // Take full width
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Inner padding for text
              decoration: BoxDecoration(
                color: Colors.grey[100], // Background color
                border: Border.all(
                  color: Colors.grey[400] ?? Colors.grey, // Border color
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              child: Text(
                cipheredText,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[800], // Text color
                  height: 1.4, // Line height for better readability of multi-line text
                ),
                textAlign: TextAlign.start, // Align text to the start
              ),
            ),
            const SizedBox(height: fieldSpacing * 1.5),

          ],
        ),
      ),
    );
  }
}
