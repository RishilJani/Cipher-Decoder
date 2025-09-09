import 'package:http/http.dart' as http;
import 'package:cipher_decoder/utils/import_export.dart';


class ApiRepo{
  var url = Uri.parse(BASE_URL);

  Future<bool> sendData({data}) async{
    print("sending data using api ::::::::: ");
    try {
      var res = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      if(res.statusCode == 200){
        print("data sent using api ::::::::: ");
        return true;
      }else{
        print("Error....... ${res.statusCode}");
        return false;
      }
    } catch(e){
      print("Error....... $e");
      return false;
    }
  }
}