import 'package:get/get.dart';
import 'package:pixabay_demo/screens/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashController.new);
  }
}
