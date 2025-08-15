import 'package:cipher_decoder/utils/import_export.dart';

// ignore: must_be_immutable
class DecodingView extends StatelessWidget{
  DecodingController decodingController = DecodingController();
  EncodeDecodeOptionsController encodeDecodeOptionsController  = Get.put(EncodeDecodeOptionsController());

  double height = 10;
  static const double fieldSpacing = 20.0;

  DecodingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_DECODING , context: context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //region decoding
              myInputfield(
                context: context,
                textTitle: "Enter text to decode",
                hintText: 'enter text to decipher...',
                controller: decodingController.cipherTextController,
                minLines: 3,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onChanged: (value) { encodeDecodeOptionsController.onChange(controller: decodingController); },
                optional: decodingController.plainTextController,
                suffixIcon: pasteIconButton(controller: decodingController.cipherTextController,onChange: encodeDecodeOptionsController.onChange),
              ),
              SizedBox(height: height),
              // endregion

              getOptionList(controller: decodingController),

              addOptionButton(controller: decodingController),

              const SizedBox(height: fieldSpacing),

              // region DecodedText
              myInputfield(
                context: context,
                controller: decodingController.plainTextController,
                textTitle: "Decoded text:",
                hintText: "Decoded text...",
                readonly: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    copyText(decodingController.plainTextController.text);
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: "Copy decoded text only",
                ),
              ),
              const SizedBox(height: fieldSpacing * 1.5),
              // endregion

              // region Description
              Obx(() {
                return description(
                    context: context,
                    controller: encodeDecodeOptionsController,
                );
              }),
              // endregion
            ],
          ),
        ),
      ),
    );
  }
}
