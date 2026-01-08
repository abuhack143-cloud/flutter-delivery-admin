import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/collectionPoint.dart';
import 'package:admin/data/model/OrderCityModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCollectionPointControllerImp extends GetxController {
  late TextEditingController point;
  late TextEditingController pointlocations;
  late TextEditingController pointTime;
  late TextEditingController pointDetail;
  late TextEditingController pointMaps;

  StatusRequest statusRequest = StatusRequest.none;

  CollectionPointData collectionPointData = CollectionPointData(Get.find());

  List<OrderCityModel> dataCity = [];
  List<SelectedListItem> city = [];
  String selectcity = '';
  List<String> valueCity = [];
  bool isCityError = false;

  Future<void> cityData() async {
    dataCity.clear();
    var response = await collectionPointData.getCity();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataCity.addAll(responseData.map((e) => OrderCityModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataCity.add(OrderCityModel.fromJson(mapData));
        }

        if (dataCity.isNotEmpty) {
          city = dataCity
              .map((item) => SelectedListItem(
                  data: "${item.cityName}", value: "${item.cityId}"))
              .toList();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> addPointData() async {
    var response = await collectionPointData.addCollectionPoint(
      valueCity.join(" ,"),
      point.text.toString(),
      pointlocations.text.toString(),
      pointTime.text.toString(),
      pointDetail.text.toString(),
      pointMaps.text.toString(),
    );

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
    point = TextEditingController();
    pointlocations = TextEditingController();
    pointTime = TextEditingController();
    pointDetail = TextEditingController();
    pointMaps = TextEditingController();
    cityData();
    super.onInit();
  }
}
