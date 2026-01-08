import 'package:admin/data/datasource/remote/order/storage.dart';
import 'package:admin/data/model/storageordermodel.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class DetailStorageController extends GetxController {
  void goToOrder() {}
}

class DetailStorageControllerImp extends DetailStorageController {
  String? orderDetail;
  List<StorageOrderModel> data = [];
  StatusRequest statusRequest = StatusRequest.none;
  StorageData storageData = StorageData(Get.find());
  MyServices myServices = Get.find();

  Future<void> viewDetail() async {
    data.clear();
    var response = await storageData.getDetail(orderDetail.toString());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => StorageOrderModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(StorageOrderModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      orderDetail = Get.arguments["order_detail"];
    }
    viewDetail();

    update();
    super.onInit();
  }
}
