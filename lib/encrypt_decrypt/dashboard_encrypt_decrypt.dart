import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DashboardEncryptDecrypt extends StatelessWidget {
  const DashboardEncryptDecrypt({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myAppBar(
          title: APPLICATION_NAME,
          context: context,
          bottom: const TabBar(
            indicatorColor: cyberpunkPurple,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Encryption"),
              Tab(text: "Decryption"),
            ]
          ),
        ),
        body: TabBarView(children: [
          EncryptionView(),
          DecryptionView(),
        ]),
      ),
    );
  }
}
