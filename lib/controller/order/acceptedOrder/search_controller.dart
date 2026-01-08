import 'package:admin/data/datasource/remote/order/accepted.dart';
import 'package:admin/data/model/orderModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class SearchController extends GetxController {}

class SearchControllerImp extends SearchController {
  TextEditingController search = TextEditingController();
  bool noResult = false;
  String? id;
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List<SelectedListItem> filter = [];
  String selectedFilter = "All";
  String selectedItems = "All";
  List<OrderModel> data = [];

  OrderAcceptedData orderAcceptedsData = OrderAcceptedData(Get.find());

  @override
  void onInit() {
    super.onInit();
    initialData();
    setupFilterOptions();
    var args = Get.arguments;
    if (args != null) {
      search.text = args['text'] ?? "";
      selectedFilter = args['title'] ?? "All";
      selectedItems = args['value'] ?? "All";
      if (selectedFilter != "All") {
        getData(selectedItems);
      } else {
        performSearch(selectedItems);
      }
    } else {
      performSearch(selectedItems);
    }
  }

  void initialData() {
    id = myServices.sharedPreferences.getString('id');
  }

  void setupFilterOptions() {
    filter.addAll([
      SelectedListItem(data: "all".tr, value: "All"),
      SelectedListItem(data: "not_accepted".tr, value: "0"),
      SelectedListItem(data: "accepted".tr, value: "1"),
      SelectedListItem(data: "DeliveryAccept".tr, value: "2"),
      SelectedListItem(data: "Received".tr, value: "3"),
      SelectedListItem(data: "deliveryToAdmin".tr, value: "4"),
      SelectedListItem(data: "deliveryToCustomer".tr, value: "5"),
      SelectedListItem(data: "deliveredNoCity".tr, value: "6"),
      SelectedListItem(data: "city".tr, value: "7"),
      SelectedListItem(data: "Delivered".tr, value: "8"),
      SelectedListItem(data: "Fail".tr, value: "9"),
    ]);
  }

  Future<void> getData(String status) async {
    data.clear();
    var response = await orderAcceptedsData.getData(
      status,
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        noResult = false;
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => OrderModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(OrderModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
        noResult = true;
      }
    }
    update();
  }

  Future<void> performSearch(String selectedItemsString) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    selectedItemsString = selectedItems;

    var response = await orderAcceptedsData.searchData(
      search.text,
      selectedItemsString,
    );

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success &&
        response['status'] == "success") {
      noResult = false;
      var responseData = response['data'];
      if (responseData is List) {
        data.addAll(responseData.map((e) => OrderModel.fromJson(e)));
      } else if (responseData is Map) {
        data.add(OrderModel.fromJson(Map<String, dynamic>.from(responseData)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      noResult = true;
    }

    update();
  }
}
