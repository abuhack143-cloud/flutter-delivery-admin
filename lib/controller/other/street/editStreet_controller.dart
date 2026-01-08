import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/street.dart';
import 'package:admin/data/model/OrderCityModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditStreetControllerImp extends GetxController {
  String? street;
  String? id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController streetName;
  late TextEditingController streetNumber;
  late TextEditingController price;

  List<SelectedListItem> city = [];
  List<String> selectcity = [];
  String selectedCity = '';
  List<OrderCityModel> data = [];

  bool isCityError = false;

  StatusRequest statusRequest = StatusRequest.loading;

  StreetData streetData = StreetData(Get.find());

  Future<void> cityData() async {
    data.clear();
    var response = await streetData.getCity();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => OrderCityModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(OrderCityModel.fromJson(mapData));
        }

        if (data.isNotEmpty) {
          city = data
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

  Future<void> editStreet() async {
    var response = await streetData.editStreet(
      id.toString(),
      selectedCity,
      streetName.text.toString(),
      streetNumber.text.toString(),
      price.text.toString(),
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
    streetName = TextEditingController();
    streetNumber = TextEditingController();
    price = TextEditingController();
    cityData();
    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      streetName.text = arg['street'];
      streetNumber.text = arg['number'];
      price.text = arg['price'];
      selectcity = [arg['city']];
      selectedCity = arg['cityId'];
      street = arg['street'];
    }

    super.onInit();
  }
}
