import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/order/orderCustommer.dart';
import 'package:admin/data/model/adminModel.dart';
import 'package:get/get.dart';

class AdminCityControllerImp extends GetxController {
  String? selectedValue;
  String? selectedLang;

  StatusRequest statusRequest = StatusRequest.loading;

  List<AdminModel> data = [];
  OrderCustommerData orderData = OrderCustommerData(Get.find());

  MyServices myServices = Get.find();

  String? orderid;

  Future<void> refreshData() async {
    // statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  Future<void> getdata() async {
    data.clear();

    var response = await orderData
        .admin(selectedValue != null ? selectedValue.toString() : "0");

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => AdminModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(AdminModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  Future<void> selectAdmin(String adminid) async {
    var response = await orderData.selectAdmin(
      orderid.toString(),
      adminid,
    );
    print(adminid);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: "refresh");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;
    if (arg != null) {
      orderid = arg['orderid'];
    }
    getdata();
  }
}
