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
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
        style: textTheme.bodyLarge,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
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

// to convert String into EncodeDecodeTypes enum
EncodeDecodeTypes fromString(String s){
  if(s == EN_CEASER_CIPHER){
    return EncodeDecodeTypes.Ceaser_Cipher;
  }else if(s == EN_ATBASH_CIPHER){
    return EncodeDecodeTypes.Atbash_Cipher;
  }else{
    return EncodeDecodeTypes.Mono_Alphabatic_Cipher;
  }
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