import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/city.dart';
import 'package:admin/data/model/OrderCityModel.dart';
import 'package:admin/data/model/classificationModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:get/get.dart';

class CityControllerImp extends GetxController {
  List<OrderCityModel> dataCity = [];

  List<String> checkbox = [];

  StatusRequest statusRequest = StatusRequest.loading;
  CityData citydata = CityData(Get.find());

  List<bool> checkboxStates = [];

  List<SelectedListItem> classification = [];
  List<String> listClasss = [];
  List<String> stringclass = ['all'];
  List<CityClassificationModel> data = [];

  bool isClassError = false;

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

  Future<void> cityData() async {
    dataCity.clear();
    var response = await citydata.getCity(stringclass);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataCity.addAll(responseData.map((e) => OrderCityModel.fromJson(e)));
          checkboxStates.addAll(List.filled(dataCity.length, false));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataCity.add(OrderCityModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deleteData() async {
    var response = await citydata.deleteCity(checkbox.toList());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        checkboxStates = [];
        listClasss = [];
        stringclass = ['all'];
        cityData();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void toggleCheckbox(int index) {
    checkboxStates[index] = !checkboxStates[index];
    update();
  }

  bool selectAll = false;

  void selectAllCheckbox() {
    checkboxStates.clear();
    checkboxStates.addAll(List.filled(dataCity.length, selectAll));
    update();
  }

  String selectallText = "select_all".tr;

  void selectAllFunction() {
    if (selectAll) {
      selectAll = false;
      selectallText = "select_all".tr;
    } else {
      selectAll = true;
      selectallText = 'Deselect_all'.tr;
    }
    update();

    selectAllCheckbox();

    checkbox = [];
  }

  Future<void> navigateEditPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.editcity, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cityData();
    }
  }

  String? ref;

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addCity);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cityData(); // إعادة تحميل البيانات بعد العودة
    }
  }

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await cityData();
    update();
  }

  @override
  void onInit() {
    cityData();
    classData();
    super.onInit();
  }
}
