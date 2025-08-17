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

String dynamicDescription({controller,String? text1, String? text2}) {
  if(controller != null){
    if(controller is EncryptionController){
      text1 ??= controller.plainTextController.text;
      text2 ??= controller.cipherTextController.text;
    }
    else{
      text1 ??= controller.cipherTextController.text;
      text2 ??= controller.plainTextController.text;
    }
  }
  const int maxLimit = 10;
  String ans = '';
  int count = 0;
  String ignore = "\n ";
  var l1 = text1!.split('');
  var l2 = text2!.split('');
  for (int i = 0; i < l1.length; i++) {
    if (i == 0) {
      ans = "\ne.g.\n";
    }

    if (ignore.contains(l1[i])) {
      continue;
    }

    if (count == maxLimit) {
      ans = "$ans...";
      break;
    }
    ans = "$ans${l1[i]} -> ${l2[i]}\n";
    count++;
  }
  return ans;
}

List<EncryptionDecryptionMethods> _encryptionDecryptionMethods = [];

List<EncryptionDecryptionMethods> get encryptionDecryptionMethods {
  if(_encryptionDecryptionMethods.isEmpty){
    for (EncryptionDecryptionTypes element in EncryptionDecryptionTypes.values) {
      if(element == EncryptionDecryptionTypes.Ceaser_Cipher){ _encryptionDecryptionMethods.add(CeaseCipher());}
      else if(element == EncryptionDecryptionTypes.Atbash_Cipher){ _encryptionDecryptionMethods.add(AtbashCipher());}
      else if(element == EncryptionDecryptionTypes.Mono_Alphabatic_Cipher){ _encryptionDecryptionMethods.add(MonoAlphabaticCipher(key: 1));}
      else if(element == EncryptionDecryptionTypes.Rail_Fence_Cipher){ _encryptionDecryptionMethods.add(RailFenceCipher(key: 1));}
    }
  }
  return _encryptionDecryptionMethods;
}

