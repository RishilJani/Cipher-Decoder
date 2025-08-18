import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DecodeView extends StatelessWidget {
  const DecodeView({super.key});

  @override
  Widget build(BuildContext context) {
    DecodeController decodeController = DecodeController();
    return const Scaffold(
      body: Center(
        child: Text("Decoding",style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
