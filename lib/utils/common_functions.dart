import 'package:cipher_decoder/utils/import_export.dart';


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
    inputFormatters,
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
              suffixIcon ?? const SizedBox(width: 0,),
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
        inputFormatters: inputFormatters
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

// to paste text from clipboard
void pasteText({controller, required Function onChange, bool isEncode = true}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {
    controller.text = data.text!;
    onChange(controller: controller,isEncode: isEncode);
  } else {
    print("::::PASTE DATA is NULL ::::::");
  }
}

// paste Icon button
Widget pasteIconButton({ controller, onChange , isEncode}) {
  return IconButton(
      onPressed: () {
        pasteText(controller: controller, onChange: onChange, isEncode : isEncode);
      },
      icon: const Icon(Icons.paste)
  );
}

// clear Icon button
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

