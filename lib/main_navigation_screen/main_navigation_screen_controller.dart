import 'package:cipher_decoder/utils/import_export.dart';

class MainNavigationScreenController extends GetxController{
  var selectedIndex = 0.obs;
  late TabController tabController;

  void setTabController(TabController controller) {
    tabController = controller;
  }
  void changeIndex(int ind){
    selectedIndex.value = ind;
    tabController.animateTo(
      ind,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInCubic,
    );
  }
}