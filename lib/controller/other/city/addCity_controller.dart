import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/city.dart';
import 'package:admin/data/model/classificationModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCityControllerImp extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cityName;
  late TextEditingController cityPlate;
  late TextEditingController cityPrice;

  List<SelectedListItem> classification = [];
  List<String> selectcity = [];
  List<String> selectedCity = [];
  List<CityClassificationModel> data = [];

  bool isCityError = false;

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

  void classfunction(List<dynamic> selectedList) {
    if (selectedList.isNotEmpty) {
      selectcity = selectedList
          .whereType<SelectedListItem>()
          .map((item) => item.data.toString())
          .toList();

      selectedCity = selectedList
          .whereType<SelectedListItem>()
          .map((item) => item.value.toString())
          .toList();
      isCityError = false;

      // تحديث واجهة المستخدم
      update();
    }
  }

  Future<void> addcity() async {
    var response = await citydata.addCity(
        cityName.text.toString(),
        selectedCity.join(" ,"),
        cityPlate.text.toString(),
        cityPrice.text.toString());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: 'refresh');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    cityName = TextEditingController();
    cityPlate = TextEditingController();
    cityPrice = TextEditingController();
    classData();
    super.onInit();
  }
}
