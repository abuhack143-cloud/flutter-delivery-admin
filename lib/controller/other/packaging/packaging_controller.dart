import 'dart:async';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/Packaging.dart';
import 'package:admin/data/model/packageModel.dart';
import 'package:get/get.dart';

class PackagingControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  List<PackagingModel> data = [];

  PackagingData packagingData = PackagingData(Get.find());

  Future<void> getPackaging() async {
    data.clear();
    var response = await packagingData.getPackaging();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => PackagingModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(PackagingModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deletePackaging(String id) async {
    var response = await packagingData.deletePackaging(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getPackaging();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addPackaging);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await getPackaging();
    }
  }

  Future<void> navigateEditPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.editPackaging, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await getPackaging();
    }
  }

  @override
  void onInit() {
    getPackaging();
    super.onInit();
  }
}
