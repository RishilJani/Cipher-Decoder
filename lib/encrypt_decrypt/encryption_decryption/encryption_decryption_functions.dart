import 'package:cipher_decoder/utils/import_export.dart';

Widget description({required context, controller}){
  if(controller is EncodeController || controller is DecodeController){
    return const SizedBox(height: 0,);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDescriptionList(controller: controller,context: context),
         Text(controller.desc.value)
      ],
    ),
  );
}

Widget getDescriptionList({ controller , context}){
  final theme = Theme.of(context);
  var textTheme = theme.textTheme;

  return ListView.builder(
    shrinkWrap: true,
    itemCount: controller.options.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.options[index].title!, style: textTheme.titleMedium?.copyWith(fontSize: 18)),
          Text(controller.options[index].description!, style: textTheme.bodyMedium,),
          const SizedBox(height: 13,)
        ],
      );
    },
  );
}
