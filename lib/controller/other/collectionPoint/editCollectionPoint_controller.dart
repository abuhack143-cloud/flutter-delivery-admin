import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/collectionPoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCollectionPointControllerImp extends GetxController {
  String? thePoint;

  String? id;
  late TextEditingController pointCity;
  late TextEditingController point;
  late TextEditingController pointlocations;
  late TextEditingController pointTime;
  late TextEditingController pointDetail;
  late TextEditingController pointMaps;

  StatusRequest statusRequest = StatusRequest.none;

  CollectionPointData collectionPointData = CollectionPointData(Get.find());

  Future<void> editPointData() async {
    var response = await collectionPointData.editCollectionPoint(
      id.toString(),
      pointCity.text.toString(),
      point.text.toString(),
      pointlocations.text.toString(),
      pointTime.text.toString(),
      pointDetail.text.toString(),
      pointMaps.text.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
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
    pointCity = TextEditingController();
    point = TextEditingController();
    pointlocations = TextEditingController();
    pointTime = TextEditingController();
    pointDetail = TextEditingController();
    pointMaps = TextEditingController();

    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      pointCity.text = arg['pointCity'];
      point.text = arg['point'];
      pointlocations.text = arg['pointlocations'];
      pointTime.text = arg['pointTime'];
      pointDetail.text = arg['pointDetail'];
      pointMaps.text = arg['pointMaps'];
      thePoint = arg['pointCity'];
    }

    super.onInit();
  }
}
