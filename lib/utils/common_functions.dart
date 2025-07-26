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
          suffixIcon: suffixIcon,
          fillColor: Colors.grey[100],
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
      Get.snackbar(
          "Success",
          "Cipher text copied successfully",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM
      );
    },
  );
}


// custom Appbar
AppBar myAppBar({required String title}){
  return AppBar(
    title: Text(title, style: const TextStyle(
      fontSize: 20,
    ),),
    centerTitle: true,
  );
}


String encodeDecodeString(EncodeDecodeTypes method){
  if(method == EncodeDecodeTypes.Mono_Alphabatic_Cipher){
    return EN_MONO_ALPHABATIC;
  }else if(method == EncodeDecodeTypes.Atbash_Cipher){
    return EN_ATBASH_CIPHER;
  }else if(method == EncodeDecodeTypes.Ceaser_Cipher){
    return EN_CEASER_CIPHER;
  }
  return "";
}