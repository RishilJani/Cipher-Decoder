import 'package:cipher_decoder/utils/import_export.dart';

// ignore:must_be_immutable
class EncodeDecodeOptions extends StatelessWidget {
  final dynamic controller;
  int? index;
  EncodeDecodeOptionsController encodeDecodeOptionsController = Get.find<EncodeDecodeOptionsController>();
  String txt = '';

  EncodeDecodeOptions({super.key, required this.controller, this.index}){
    txt = 'Select method to ${controller is EncodingController ? 'encode' : 'decode'}';
  }

  double fieldSpacing = 20.0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final textTheme = theme.textTheme;
    int n = encodeDecodeOptionsController.options.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // region Custom Dropdown Button
        Row(
          children: [
            Text(
              '${n > 1 ? '${index! + 1}.) ' : ''}$txt',
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
             n > 1
                ? IconButton(
                    onPressed: () {
                      encodeDecodeOptionsController.removeWidget(index: index, controller: controller);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
          ],
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
                    encodeDecodeOptionsController.options[index!].title!,
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
            child: encodeDecodeOptionsController.options[index!].requiresKey
                ? myInputfield(
                    key: const ValueKey('conditionalField'),
                    context: context,
                    textTitle: 'Enter Key:',
                    hintText: 'Enter Integer Key...',
                    controller: controller.keyController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      encodeDecodeOptionsController.keyUpdateWidget(
                          index: index, controller: controller);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                    ],
                  )
                : const SizedBox.shrink(key: ValueKey('emptyConditional')),
          ),
        ),

        Obx(
          () => Visibility(
            visible: !encodeDecodeOptionsController.options[index!].requiresKey,
            child: SizedBox(
              height: fieldSpacing * 1.5,
            ),
          ),
        ),
      ],
    );
  }

  void showMethodDialog({ThemeData? theme}) {
    TextTheme textTheme = theme!.textTheme;
    Get.defaultDialog(
      title: 'Select an Option',
      content: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 9,
          childAspectRatio: 3 / 1,
          children: encodeDecodeMethods.map((method) {
            return Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                  onTap: () {
                    // keyFieldController.updateSelectedMethod(method,controller: controller);
                    encodeDecodeOptionsController.updateWidget(
                        methodObj: method,
                        index: index,
                        controller: controller);
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      method.title!,
                      style: textTheme.bodyMedium,
                    ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}
