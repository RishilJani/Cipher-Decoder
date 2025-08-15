import 'package:cipher_decoder/utils/import_export.dart';
// ignore: must_be_immutable
class DashboardEncryptDecrypt extends StatelessWidget {
  DashboardEncryptDecrypt({super.key});
  EncryptionDecryptionOptionsController encodeDecodeOptionsController  = Get.put(EncryptionDecryptionOptionsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myAppBar(
          title: APPLICATION_NAME,
          context: context,
          bottom: const TabBar(
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

/*
Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: [
          Row(
            children: [
              myTabs( title: "Encryption", index: 0 , context: context ),
              myTabs( title: "Decryption", index: 1 , context: context),
            ],
          ),

          Expanded(
              child: selectedIndex == 0 ? encrypted : decrypted,
          )
        ],
      ),
    );
 */
