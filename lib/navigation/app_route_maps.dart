import 'package:get/route_manager.dart';

import 'app_pages.dart';

abstract class AppRouteMaps {
  static void goToHomeViewPage() {
    Get.offAllNamed(Routes.home);
  }
}
