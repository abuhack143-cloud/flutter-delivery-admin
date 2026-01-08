import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/collectionPoint.dart';
import 'package:admin/data/model/pointModel.dart';

import 'package:get/get.dart';

class CollectionPointControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  List<PointModel> data = [];

  CollectionPointData collectionPointData = CollectionPointData(Get.find());

  Future<void> onRefresh() async {
    statusRequest = StatusRequest.loading;
    update();
    await pointData();
  }

  Future<void> pointData() async {
    data.clear();
    var response = await collectionPointData.getCollectionPoint();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => PointModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(PointModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deletePointData(String id) async {
    var response = await collectionPointData.deleteCollectionPoint(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        pointData();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addCollectionPoint);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await pointData();
    }
  }

  Future<void> navigateEditPage(dynamic arg) async {
    var result =
        await Get.toNamed(AppRoute.editCollectionPoint, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await pointData();
    }
  }

  @override
  void onInit() {
    pointData();
    super.onInit();
  }
}
