import 'package:get/get.dart';

import '../pages/profile/provider/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(
      () => LanguageController(),
    );
  }
}
