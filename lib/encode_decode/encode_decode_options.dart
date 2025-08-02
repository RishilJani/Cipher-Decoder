import 'package:cipher_decoder/utils/import_export.dart';

// ignore:must_be_immutable
class EncodeDecodeOptions extends StatelessWidget {
  final dynamic controller;
  KeyFieldController keyFieldController = Get.find<KeyFieldController>();
  EncodeDecodeOptions({super.key, required this.controller});

  double fieldSpacing = 20.0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // region Custom Dropdown Button
        Text(
          'Select method to encode:',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize:
                  const Size.fromHeight(60), // Makes the button fill width
              backgroundColor: Colors.grey[100],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            onPressed: () {
              showMethodDialog(theme: theme);
            },
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    keyFieldController.selectedMethod.value.title!,
                    style: textTheme.bodyMedium,
                  ),
                  Icon(Icons.arrow_drop_down_circle_sharp,
                      color: theme.primaryColor, size: 28),
                ],
              ),
            )),
        //endregion

        Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: keyFieldController.showConditionalField.value
                ? myInputfield(
                    key: const ValueKey('conditionalField'),
                    context: context,
                    textTitle: 'Enter Key:',
                    hintText: 'Enter Integer Key...',
                    controller: controller.keyController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      keyFieldController.onChange(controller: controller, isEncode: controller.runtimeType == EncodingController);
                    },
                    suffixIcon: clearIconButton( controller: controller.keyController, text: "Clear Key"))
                : const SizedBox.shrink(key: ValueKey('emptyConditional')),
          ),
        ),

        Obx(
            () => Visibility(
                visible: !keyFieldController.showConditionalField.value,
                child: SizedBox(height: fieldSpacing * 1.5,),
            ),
        ),
      ],
    );
  }

  void showMethodDialog({theme}) {
    Get.defaultDialog(
      title: 'Select an Option',
      content: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 4.5,
          children: encodeDecodeMethods.map((method) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                // Reduced padding and font size for smaller buttons.
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                keyFieldController.updateSelectedMethod(method,controller: controller ,isEncode: controller.runtimeType == EncodingController);
              },
              child: Text(
                method.title!,
                style: const TextStyle(fontSize: 14), // Smaller font size.
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
