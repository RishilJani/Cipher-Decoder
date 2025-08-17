import 'package:cipher_decoder/utils/import_export.dart';

class EncodeView extends StatelessWidget {
  const EncodeView({super.key});

  @override
  Widget build(BuildContext context) {
    var method = Base64();
    String ans = method.encode(plainText: "Hello World");
    return  Scaffold(
      body: Center(
        child: Text("$ans",style: const TextStyle(fontSize: 18),),
      ),
    );
  }
}
