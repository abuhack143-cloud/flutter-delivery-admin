import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:admin/core/class/crud.dart';

class InBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
