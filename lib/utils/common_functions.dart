import 'package:cipher_decoder/utils/import_export.dart';


// custom Appbar
AppBar myAppBar({required String title, context}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return AppBar(
    title: Text(
      title,
      style: textTheme.titleLarge
    ),
    centerTitle: true,
  );
}

// custom text input field
Widget myInputfield(
    {key,
    required context,
    required String textTitle,
    String? hintText,
    suffixIcon,
    TextEditingController? controller,
    minLines,
    maxLines,
    keyboardType,
    textInputAction,
    inputFormatters,
    onChanged,
    validator,
    TextEditingController? optional,
    bool readonly = false,
    encodeDecodeController
    }) {
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
          hintStyle: textTheme.bodyMedium?.copyWith( color: Colors.black ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon ?? const SizedBox(width: 0,),
              clearIconButton(controller: controller,optional: optional,encodeDecodeController: encodeDecodeController),
            ],
          ),
          suffixIconColor: darkSurface
        ),
        style: textTheme.bodyMedium?.copyWith(color: darkElevatedSurface),
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
void pasteText({controller, required Function onChange}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {
    controller.text = data.text!;
    onChange(controller: controller);
  } else {}
}

// paste Icon button
Widget pasteIconButton({ controller, onChange}) {
  return IconButton(
      onPressed: () {
        pasteText(controller: controller, onChange: onChange);
      },
      icon: const Icon(Icons.paste)
  );
}

// clear Icon button
Widget clearIconButton({TextEditingController? controller , TextEditingController? optional , encodeDecodeController}){
  EncodeDecodeOptionsController? encodeDecodeOptionsController;
  try{ encodeDecodeOptionsController = Get.find<EncodeDecodeOptionsController>();}
  catch(e){ encodeDecodeOptionsController  = null; }
  return IconButton(
    onPressed:  () {
      controller!.clear();
      if(optional != null){ optional.clear(); }
      if(encodeDecodeOptionsController != null) {
        encodeDecodeController.changeDescription(controller: encodeDecodeController);
      }
    },
    icon: const Icon(Icons.clear, color: darkError,size: 32),
    tooltip: "Clear",
  );
}

Widget addOptionButton({ controller }){
  EncodeDecodeOptionsController encodeDecodeOptionsController = Get.find<EncodeDecodeOptionsController>();
  return Container(
    decoration: BoxDecoration(
      color: darkElevatedSurface,
      border: Border.all(color: darkAccent,width: 3),
      borderRadius: BorderRadius.circular(15)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
          onPressed: (){
            encodeDecodeOptionsController.addWidget(methodObj: CeaseCipher(), controller: controller);
          },
          hoverColor: Colors.red,
          icon: const Icon(Icons.add,size: 25,)),
        )
      ],
    ),
  );
}