import 'package:cipher_decoder/utils/import_export.dart';

// custom Appbar
AppBar myAppBar({ String title = '',required context, bottom}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return AppBar(
    title: Text(
      title,
      style: textTheme.titleLarge
    ),
    centerTitle: true,
    bottom: bottom,
  );
}

Widget myScreen({ context , controller , titleText , methodsController , isEncoding = true}){
  if(!checkAllTypes(controller: controller)){
    throw ControllerTypeException(message: "Controller is Not right ::: ${controller.runtimeType}");
  }
  double height = 10;
  const double fieldSpacing = 20.0;

  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // region Encryption
          myInputfield(
            context: context,
            textTitle: titleText,
            hintText: titleText,
            controller: isEncoding ?  controller.plainTextController : controller.cipherTextController,
            minLines: 3,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            onChanged: (value) {
              // on change function here
              if(controller is EncryptionController || controller is DecryptionController){
                methodsController.onChange(controller: controller);
              }
            },
            optional: isEncoding ? controller.cipherTextController : controller.plainTextController,
            suffixIcon: pasteIconButton( controller: controller,  onChange: methodsController.onChange),

          ),
          SizedBox(height: height),
          // endregion

          getOptionList(controller: controller),

          addOptionButton(controller: controller),

          const SizedBox(height: fieldSpacing),

          // region Encrypted
          myInputfield(
            context: context,
            controller: isEncoding ?  controller.cipherTextController : controller.plainTextController,
            textTitle: "Encrypted text:",
            hintText: "Encrypted text...",
            readonly: true,
            suffixIcon: IconButton(
              onPressed: () {
                String cpy = isEncoding ?  controller.cipherTextController.text.toString() : controller.plaintextController.text.toString();
                copyText(cpy);
              },
              icon: const Icon(Icons.copy),
              tooltip: "Copy encrypted text",
            ),
          ),
          const SizedBox(height: fieldSpacing * 1.5),
          // endregion

          // region Description
          Obx(
                  () {
                return description(
                  context: context,
                  controller: methodsController,
                );
              }
          ),
          // endregion
        ],
      ),
    ),
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
    encodeDecodeController,
    bool isEncode = true,
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
void pasteText({ controller ,required Function onChange}) async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  if (data != null) {
    if(controller is EncodeController || controller is EncryptionController){
      controller.plainTextController.text = data.text!;
    }else if(controller is DecodeController || controller is DecryptionController){
      controller.cipherTextController.text = data.text!;
    }

    print("::::::DATA is Pasted..... = ${data.text}");
      print("::::::Controller = ..... = ${controller.runtimeType}");
      print("::::::Controller = ..... = ${controller.runtimeType}");
    // controller.text = data.text!;
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
  EncryptionDecryptionOptionsController? encodeDecodeOptionsController;
  try{ encodeDecodeOptionsController = Get.find<EncryptionDecryptionOptionsController>();}
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
  EncryptionDecryptionOptionsController encodeDecodeOptionsController = Get.find<EncryptionDecryptionOptionsController>();
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

bool checkAllTypes({controller}){
  return controller is EncryptionController || controller is DecryptionController || controller is EncodeController || controller is DecodeController;
}

