// ignore_for_file: unused_element

import 'package:get/get.dart';
import 'package:pixabay_demo/screens/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
  }
}
