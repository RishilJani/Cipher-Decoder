import 'package:cipher_decoder/utils/import_export.dart';

Map<dynamic,dynamic> methods = {
  EncodeDecodeTypes.Ceaser_Cipher : CEASER_CIPHER_DESC,
  EncodeDecodeTypes.Atbash_Cipher : ATBASH_CIPHER_DESC,
  EncodeDecodeTypes.Mono_Alphabatic_Cipher : MONO_ALPHABATIC_CIPHER_DESC,
};

List<EncodeDecodeTypes> encodeDecodeMethods = EncodeDecodeTypes.values;
List<EncodeDecodeTypes> keyRequired = [EncodeDecodeTypes.Mono_Alphabatic_Cipher];


// to convert String into EncodeDecodeTypes enum
EncodeDecodeTypes fromString(String s) {
  if(s == EN_CEASER_CIPHER){
    return EncodeDecodeTypes.Ceaser_Cipher;
  }else if(s == EN_ATBASH_CIPHER){
    return EncodeDecodeTypes.Atbash_Cipher;
  }else{
    return EncodeDecodeTypes.Mono_Alphabatic_Cipher;
  }
}

Widget description({required context, selectedMethod, text1 , text2 }){
  final theme = Theme.of(context);
  var textTheme = theme.textTheme;

  String des = dynamicDescription(text1: text1,text2: text2);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(encodeDecodeString(selectedMethod),style: textTheme.titleMedium?.copyWith(fontSize: 18)),
        Text(methods[selectedMethod], style: textTheme.bodyMedium,),
        Text(des)
      ],
    ),
  );
}

String dynamicDescription({required String text1 ,required String text2}){
  String ans = "";
  int count = 0;
  var l1 = text1.split('');
  var l2 = text2.split('');
  for(int i = 0 ; i < l1.length; i++){
    if(count == 7){
      ans = "$ans...";
      break;
    }
    ans = "$ans${l1[i]} -> ${l2[i]}\n";
    count++;
  }
  print("ans = $ans");
  return ans;
}