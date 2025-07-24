import 'package:cipher_decoder/utils/import_export.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_DASHBOARD),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customIconButton(
                onPressed: () { Get.toNamed(RT_ENCODING_VIEW); },
                child: const Text("Encoding")
              ),

              customIconButton(
                  onPressed: (){
                    Get.toNamed(RT_DECODING_VIEW);
                  },
                  child: const Text("Decoding")
              ),
            ],
          )
        ],
      )
    );
  }

  Widget customIconButton({child , onPressed}){
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 150,
          child: child,
        ),
      ),
    );
  }

}

/*
Note:

2 copy options : copy only cipher text || copy both plaintext and cipher text
designing : jevi live karvani che evi


ColorCode:
(Light Mode)
Bg color #E6E8FA
primary color #09E88B

(Dark Mode)
BG color #292626
primary #FFE100

*/
