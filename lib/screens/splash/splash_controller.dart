import 'package:get/get.dart';
import 'package:pixabay_demo/navigation/app_route_maps.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    
     Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
        AppRouteMaps.goToHomeViewPage();
        },
        
        );
   
    super.onInit();
  }
 
  
}
