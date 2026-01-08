import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/city.dart';
import 'package:admin/data/model/classificationModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCityControllerImp extends GetxController {
  String? theCity;
  String? id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cityName;
  late TextEditingController cityPrice;
  late TextEditingController cityPlate;

  List<SelectedListItem> classification = [];
  List<String> listClasss = [];
  String stringclass = '';
  List<CityClassificationModel> data = [];

  bool isClassError = false;

  StatusRequest statusRequest = StatusRequest.loading;

  CityData citydata = CityData(Get.find());

  Future<void> classData() async {
    data.clear();
    var response = await citydata.getClass();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(
              responseData.map((e) => CityClassificationModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(CityClassificationModel.fromJson(mapData));
        }

        if (data.isNotEmpty) {
          classification = data
              .map((item) => SelectedListItem(
                  data: "${item.classification}",
                  value: "${item.classificationId}"))
              .toList();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> editCity() async {
    var response = await citydata.editCity(
      id.toString(),
      stringclass,
      cityName.text.toString(),
      cityPrice.text.toString(),
      cityPlate.text.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: 'refresh');
      } else {
        Get.back();
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    cityName = TextEditingController();
    cityPrice = TextEditingController();
    cityPlate = TextEditingController();
    classData();
    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      cityName.text = arg['city'];
      cityPrice.text = arg['price'];
      cityPlate.text = arg['plate'];
      listClasss = [arg['classification']];
      stringclass = arg['classificationId'];
      theCity = arg['city'];
    }

    super.onInit();
  }
}
