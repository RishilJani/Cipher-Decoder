import 'package:cipher_decoder/utils/import_export.dart';

// custom text input field
Widget myInputfield(
    {key,
    required context,
    required String textTitle,
    hintText,
    suffixIcon,
    controller,
    minLines,
    maxLines,
    keyboardType,
    textInputAction,
    onChanged,
    validator,
    optional,
    readonly = false}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;

  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textTitle,
        style: textTheme.titleMedium,
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        readOnly: readonly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon,
              clearIconButton(controller: controller,text: "Clear",optional: optional),
            ],
          ),
        ),
        style: textTheme.bodyMedium,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        enableInteractiveSelection: true,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
      ),
      const SizedBox(height: 15.0),
    ],
  );
}

// to copy text into clipboard
void copyText(String txt) {
  Clipboard.setData(ClipboardData(text: txt)).then(
    (value) {
      Get.snackbar("Success", "Cipher text copied successfully",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM);
    },
  );
}

void pasteText({controller, required Function onChange}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {
    controller.text = data.text!;
    onChange();
  } else {}
}

Widget pasteIconButton({ controller, onChange }) {
  return IconButton(
      onPressed: () {
        pasteText(controller: controller, onChange: onChange);
      },
      icon: const Icon(Icons.paste)
  );
}

Widget clearIconButton({controller , text , optional }){
  return IconButton(
    onPressed: () {
      controller.clear();
      if(optional != null){ optional.clear(); }
    },
    icon: const Icon(Icons.clear),
    tooltip: text,
  );
}

// custom Appbar
AppBar myAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
    centerTitle: true,
  );
}

void showMethodDialog() async{
   await Get.dialog(
       const Text("Hello")
   ).then((value) {
     print("world value ============= $value");
   });
}

Widget dropdownKeyField({context, selectedMethod, showConditionalField, keyController, Function? onChange,double fieldSpacing = 20.0}){
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
        value: selectedMethod,
        items: encodeDecodeMethods.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.title!),
          );
        },
        ).toList(),
        onChanged: (value) {
          selectedMethod = value!;
          // onEncodeChange();
          onChange!(selectedMethod : selectedMethod);
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
                // onEncodeChange();
                onChange!();
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
        SizedBox(height: fieldSpacing * 1.5), // Adjust spacing if field is hidden
      // endregion
    ],
  );
}

void getDialog({theme, controller}){
  Get.defaultDialog(
    title: 'Select an Option',
    content: SizedBox(
      // We wrap the GridView in a SizedBox to constrain its size in the dialog.
      width: double.maxFinite,
      height: 250,
      child: GridView.count(
        shrinkWrap: true, // Allows the grid to take up minimal space.
        crossAxisCount: 2, // Two items per row.
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: encodeDecodeMethods.map((method) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // When a grid item is pressed, update the controller state.
              controller.selectMethod(method);
            },
            child: Text(method.title!),
          );
        }).toList(),
      ),
    ),
  );
}
