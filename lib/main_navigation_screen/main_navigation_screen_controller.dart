import 'package:cipher_decoder/utils/import_export.dart';

class MainNavigationScreenController extends GetxController{
  var selectedIndex = 0.obs;

  void changeIndex(int ind){
    selectedIndex.value = ind;
  }
}