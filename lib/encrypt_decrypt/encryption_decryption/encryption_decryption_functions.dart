import 'package:cipher_decoder/utils/import_export.dart';

Widget description({required context, required EncryptionDecryptionOptionsController controller}){
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

Widget getDescriptionList({required EncryptionDecryptionOptionsController controller , context}){
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

List<EncryptionDecryptionTypes> encryptionDecryptionMethods = EncryptionDecryptionTypes.values;

EncryptionDecryptionModel getMethod({required EncryptionDecryptionTypes element}){
  EncryptionDecryptionModel res;
  if(element == EncryptionDecryptionTypes.Ceaser_Cipher){ res = CeaseCipher();}
  else if(element == EncryptionDecryptionTypes.Atbash_Cipher){ res = AtbashCipher();}
  else if(element == EncryptionDecryptionTypes.Mono_Alphabatic_Cipher){
    res = MonoAlphabaticCipher(key: 1);
  }
  else if(element == EncryptionDecryptionTypes.Rail_Fence_Cipher){ res = RailFenceCipher(key: 1);}
  else{
    res = CeaseCipher();
  }
  return res;
}