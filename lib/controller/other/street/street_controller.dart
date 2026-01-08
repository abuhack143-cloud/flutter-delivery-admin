import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/street.dart';
import 'package:admin/data/model/OrderCityModel.dart';
import 'package:admin/data/model/streetModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StreetControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  StreetData streetData = StreetData(Get.find());

  List<String> checkbox = [];

  List<String> listStreetName = [];

  List<bool> checkboxStates = [];

  List<StreetModel> dataStreet = [];

  List<OrderCityModel> dataCity = [];
  List<SelectedListItem> city = [];
  List<String> selectcity = [];
  List<String> valueCity = ['all'];
  bool isCityError = false;

  int currentPage = 0; // صفحة البداية
  int pageSize = 20; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await streetdata();
    update();
  }

  Future<void> cityData() async {
    dataCity.clear();
    var response = await streetData.getCityStreet();

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

  Future<void> deleteStreet() async {
    var response = await streetData.deleteStreet(checkbox);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        checkbox = [];
        checkboxStates = [];
        city = [];
        selectcity = [];
        valueCity = ['all'];
        streetdata();
        cityData();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> streetdata({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      dataStreet.clear(); // تنظيف البيانات عند الطلب الأول
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await streetData.getStreet(valueCity, currentPage, pageSize);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          List<StreetModel> newStreetData =
              responseData.map((e) => StreetModel.fromJson(e)).toList();

          if (newStreetData.length < pageSize) {
            hasMoreData = false; // لا توجد بيانات إضافية
          }

          dataStreet.addAll(newStreetData);

          checkboxStates.addAll(List.filled(newStreetData.length, false));
          currentPage = currentPage + 20; // زيادة الصفحة
          pageSize = pageSize + 20;
        }
      } else {
        hasMoreData = false;
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
    checkboxStates.addAll(List.filled(dataStreet.length, selectAll));
    update();
  }

  String? ref;

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addstreet);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cityData();
      await streetdata();
    }
  }

  Future<void> navigateEditPage(int index) async {
    var result = await Get.toNamed(
      AppRoute.editstreet,
      arguments: {
        "id": dataStreet[index].streetId.toString(),
        "street": dataStreet[index].streetName,
        "number": dataStreet[index].streetNumber.toString(),
        "city": dataStreet[index].cityName.toString(),
        "cityId": dataStreet[index].cityId.toString(),
        "price": dataStreet[index].streetPrice.toString(),
      },
    );
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cityData();
      await streetdata();
    }
  }

  void selectAllFunction() {
    if (selectAll) {
      selectAll = false;
    } else {
      selectAll = true;
    }
    update();

    selectAllCheckbox();

    checkbox = [];
  }

  void checkBoxFunction(int index) {
    if (!checkbox.contains(dataStreet[index].streetId.toString())) {
      checkbox.add(dataStreet[index].streetId.toString());
    }

    toggleCheckbox(index);

    if (!checkboxStates[index]) {
      checkbox.remove(dataStreet[index].streetId.toString());
    }
  }

  void cityOnSelect(List<dynamic> selectedList) {
    if (selectedList.isNotEmpty) {
      selectcity = selectedList
          .whereType<SelectedListItem>()
          .map((item) => item.data.toString())
          .toList();

      valueCity = selectedList
          .whereType<SelectedListItem>()
          .map((item) => item.value.toString())
          .toList();
      isCityError = false;
      streetdata();
      update();
    }
  }

  @override
  void onInit() {
    cityData();
    streetdata();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        streetdata(isLoadMore: true);
      }
    });
    super.onInit();
  }
}
