import 'package:cipher_decoder/utils/import_export.dart';

Map<dynamic,dynamic> methods = {
  EncodeDecodeTypes.Ceaser_Cipher : CEASER_CIPHER_DESC,
  EncodeDecodeTypes.Atbash_Cipher : ATBASH_CIPHER_DESC,
  EncodeDecodeTypes.Mono_Alphabatic_Cipher : MONO_ALPHABATIC_CIPHER_DESC,
  EncodeDecodeTypes.Rail_Fence_Cipher : RAIL_FENCE_DESC,
};

List<EncodeDecodeTypes> encodeDecodeMethods = EncodeDecodeTypes.values;
List<EncodeDecodeTypes> keyRequired = [EncodeDecodeTypes.Mono_Alphabatic_Cipher, EncodeDecodeTypes.Rail_Fence_Cipher];


// to convert EncodeDecodeTypes into String
String encodeDecodeToString(EncodeDecodeTypes method){
  if(method == EncodeDecodeTypes.Mono_Alphabatic_Cipher){
    return EN_MONO_ALPHABATIC;
  }
  else if(method == EncodeDecodeTypes.Atbash_Cipher){
    return EN_ATBASH_CIPHER;
  }
  else if(method == EncodeDecodeTypes.Ceaser_Cipher){
    return EN_CEASER_CIPHER;
  }
  else if(method == EncodeDecodeTypes.Rail_Fence_Cipher) {return EN_RAIL_FENCE;}
  return "";
}

// to convert String into EncodeDecodeTypes enum
EncodeDecodeTypes encodeDecodeFromString(String s) {
  if(s == EN_CEASER_CIPHER){
    return EncodeDecodeTypes.Ceaser_Cipher;
  }else if(s == EN_ATBASH_CIPHER){
    return EncodeDecodeTypes.Atbash_Cipher;
  }else if(s == EN_MONO_ALPHABATIC){
    return EncodeDecodeTypes.Mono_Alphabatic_Cipher;
  }else{
    return EncodeDecodeTypes.Rail_Fence_Cipher;
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
        Text(encodeDecodeToString(selectedMethod),style: textTheme.titleMedium?.copyWith(fontSize: 18)),
        Text(methods[selectedMethod], style: textTheme.bodyMedium,),
        Text(des)
      ],
    ),
  );
}

String dynamicDescription({required String text1 ,required String text2}){
  String ans = "\ne.g.\n";
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