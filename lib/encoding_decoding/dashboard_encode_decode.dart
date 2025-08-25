import 'package:cipher_decoder/utils/import_export.dart';

class DashboardEncodeDecode extends StatelessWidget {
  const DashboardEncodeDecode({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: cyberpunkPurple,
          appBar: myAppBar(
            context: context,
            title: APPLICATION_NAME,
            bottom: const TabBar(
                indicatorColor: cyberpunkPurple,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: "Encode",),
                  Tab(text: "Decode",),
                ]
            )
          ),

          body: const TabBarView(
              children: [
                EncodeView(),
                DecodeView(),
              ]
          ),
        )
    );
  }
}
