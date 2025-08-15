import 'package:cipher_decoder/utils/import_export.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: APPBAR_TITLE_DASHBOARD , context: context),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customIconButton(
                  onPressed: () { Get.toNamed(RT_ENCRYPTION_VIEW); },
                  child: const Text("Encryption", style: TextStyle(
                    fontSize: 17
                  ),)
                ),
              ],
            ),
            // SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customIconButton(
                    onPressed: (){
                      Get.toNamed(RT_DECRYPTION_VIEW);
                    },
                    child: const Text("Decryption",style: TextStyle(
                        fontSize: 17
                    ),)
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget customIconButton({child , onPressed}){
    return ElevatedButton(
      onPressed: onPressed,
      child: InkWell(
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
