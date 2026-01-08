import 'package:get/get.dart';
import 'package:admin/core/services/services.dart';

class ProfileController extends GetxController {
  String? username;
  String? email;
  String? role;
  String? image;
}

class ProfileControllerImp extends ProfileController {
  MyServices myServices = Get.find();
  void initialData() {
    username = myServices.sharedPreferences.getString('username');
    email = myServices.sharedPreferences.getString('email');
    role = myServices.sharedPreferences.getString('role');
    image = myServices.sharedPreferences.getString('image');
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
