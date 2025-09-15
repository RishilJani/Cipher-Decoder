import 'package:http/http.dart' as http;
import 'package:cipher_decoder/utils/import_export.dart';

class ApiRepo{
  ApiRepo._internal();

  static ApiRepo _instance = ApiRepo._internal();
  factory ApiRepo(){
    return _instance;
  }


  var url = Uri.parse(BASE_URL);

  Future<bool> sendData(Map<String,dynamic> data) async{
    try {
      var res = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          API_KEY : "1234",
        },
      );
      if(res.statusCode == 200){
        showSnackBar( title: "Feedback",  message: "Submitted Successfully", colorText: cyberpunkBlack, backgroundColor: cyberpunkGreenLight);
        return true;
      }else{
        showSnackBar( title: "Feedback",  message: "Not submitted",  colorText: cyberpunkBlack, backgroundColor: cyberpunkRedDark);
        return false;
      }
    } catch(e){
      return false;
    }
  }
}