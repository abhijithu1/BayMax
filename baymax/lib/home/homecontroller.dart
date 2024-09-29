import 'package:get/get.dart';

class HomeController extends GetxController {
  final page_num = 0.obs;
  final List<String> titles = ["Chat", "Records", "Day Reports"];

  void setindex(index) {
    page_num.value = index;
    update();
  }
}
