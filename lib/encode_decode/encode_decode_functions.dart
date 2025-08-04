import 'package:cipher_decoder/utils/import_export.dart';

Widget description({required context, controller, required EncodeDecodeMethods selectedMethod,required String text1 ,required String text2 }){
  final theme = Theme.of(context);
  var textTheme = theme.textTheme;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(selectedMethod.title!,style: textTheme.titleMedium?.copyWith(fontSize: 18)),
        Text(selectedMethod.description!, style: textTheme.bodyMedium,),
        Text(controller.ans.value)
      ],
    ),
  );
}

String dynamicDescription({required String text1 ,required String text2}){
  String ans = '';
  int count = 0;
  String ignore = "\n ";
  var l1 = text1.split('');
  var l2 = text2.split('');
  for(int i = 0 ; i < l1.length; i++){
    if(i== 0){ ans = "\ne.g.\n"; }
    if(ignore.contains(l1[i])){continue;}
    if(count == 7){
      ans = "$ans...";
      break;
    }
    ans= "$ans${l1[i]} -> ${l2[i]}\n";
    count++;
  }
  return ans;
}

List<EncodeDecodeMethods> _encodeDecodeMethods = [];

List<EncodeDecodeMethods> get encodeDecodeMethods {
  if(_encodeDecodeMethods.isEmpty){
    for (EncodeDecodeTypes element in EncodeDecodeTypes.values) {
      if(element == EncodeDecodeTypes.Ceaser_Cipher){ _encodeDecodeMethods.add(CeaseCipher());}
      else if(element == EncodeDecodeTypes.Atbash_Cipher){ _encodeDecodeMethods.add(AtbashCipher());}
      else if(element == EncodeDecodeTypes.Mono_Alphabatic_Cipher){ _encodeDecodeMethods.add(MonoAlphabaticCipher());}
      else if(element == EncodeDecodeTypes.Rail_Fence_Cipher){ _encodeDecodeMethods.add(RailFenceCipher());}
    }
  }
  return _encodeDecodeMethods;
}