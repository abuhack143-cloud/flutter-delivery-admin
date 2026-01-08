import 'dart:async';
import 'package:admin/data/datasource/remote/order/order.dart';
import 'package:admin/data/model/orderModel.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class DetailController extends GetxController {
  void goToOrder() {}
}

class DetailControllerImp extends DetailController {
  Completer<GoogleMapController>? completercontroller;
  List<Marker> marker = [];
  double? lat;
  double? long;
  CameraPosition? cameraPosition;
  String? orderDetail;
  List<OrderModel> data = [];
  StatusRequest statusRequest = StatusRequest.none;
  OrderData ordersData = OrderData(Get.find());
  MyServices myServices = Get.find();

  Future<void> viewDetail() async {
    data.clear();
    var response = await ordersData.getDetail(orderDetail!);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
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
      }
    }
    update();
  }

  // initialData() {
  //   String latString = data.isNotEmpty ? data[0].addressLat.toString() : "";
  //   double lat = data.isNotEmpty ? double.parse(latString) : 2;

  //   String longString = data.isNotEmpty ? data[0].addressLong.toString() : "";
  //   double long = data.isNotEmpty ? double.parse(longString) : 2;
  //   cameraPosition = CameraPosition(target: LatLng(lat, long), zoom: 14.4746);
  //   marker.add(Marker(
  //     markerId: const MarkerId("1"),
  //     position: LatLng(lat, long),
  //   ));
  // }

  @override
  void onInit() {
    // initialData();
    var args = Get.arguments;
    if (args != null) {
      orderDetail = Get.arguments["order_detail"];
    }
    viewDetail();

    update();
    super.onInit();
  }
}
