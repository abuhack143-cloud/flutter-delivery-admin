import 'dart:async';
import 'package:admin/controller/order/pendingOrderCustommer/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/WebSocketService.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/order/orderCustommer.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDeliveryCustommerControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  bool info = false;

  Completer<GoogleMapController>? completercontroller;
  Position? position;

  final List<Map<String, dynamic>> locations = [];
  final Set<Marker> markers = {};

  WebSocketService? socketService;
  List<StoreOwnerModel> data = [];
  List<DeliveryModel> data1 = [];

  OrderCustommerData orderData = OrderCustommerData(Get.find());
  final Map<String, DateTime> lastUpdateTimes = {};
  void connectToWebSocket() {
    socketService = WebSocketService();
    if (socketService == null) return;

    socketService!.connect();

    socketService!.onLocationReceived = (location) async {
      final userId = location['user_id'].toString();
      lastUpdateTimes[userId] = DateTime.now(); // تحديث الوقت
      final exists = locations.any((existingLocation) =>
          existingLocation['user_id'] == location['user_id'] &&
          existingLocation['latitude'] == location['latitude'] &&
          existingLocation['longitude'] == location['longitude'] &&
          existingLocation['image'] == location['image']);

      if (!exists) {
        locations.add(location);

        if (location['type'] == 'delivery') {
          PaintImage paintImage = PaintImage();
          BitmapDescriptor customIcon = await paintImage.getMarkerIconFromUrl(
           location['image'],
            location['isdelivery'] == false
                ? "images/marker_green.png"
                : "images/marker_red.png",
          );
          final markerId = MarkerId("${location['user_id']}");
          final marker = Marker(
            markerId: markerId,
            position: LatLng(location['latitude'], location['longitude']),
            icon: customIcon,
            onTap: () {
              info = true;
              getdelivery(location['user_id']);
              update();
            },
          );

          markers.add(marker);

          update();
        }
      }
    };
    update();
  }

  void startCheckingInactiveDeliveries() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      DateTime now = DateTime.now();
      lastUpdateTimes.removeWhere((userId, lastUpdate) {
        if (now.difference(lastUpdate).inSeconds > 10) {
          markers.removeWhere((marker) => marker.markerId.value == userId);
          return true;
        }
        return false;
      });
      update();
    });
  }

  Future<void> approveOrders(String deliveryid) async {
    var response = await orderData.approve2Order(
      orderid.toString(),
      deliveryid.toString(),
      ownerid.toString(),
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

  Future<void> getdata() async {
    data.clear();
    var response = await orderData.getData(ownerid.toString());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => StoreOwnerModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(StoreOwnerModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // ignore: deprecated_member_use
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'images/marker_store.png',
      );
      data.map(
        (item) {
          double? lat = double.tryParse(item.ownerLat.toString());
          double? lng = double.tryParse(item.ownerLng.toString());
          if (lat != null && lng != null) {
            final marker = Marker(
              markerId: MarkerId("${item.ownerIDCardNumber}"),
              position: LatLng(lat, lng),
              icon: customIcon,
              onTap: () {},
            );
            markers.add(marker);
          }
        },
      ).toSet();
    }

    update();
  }

  Future<void> getdelivery(String id) async {
    data1.clear();

    var response = await orderData.deliveryData(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data1.addAll(responseData.map((e) => DeliveryModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data1.add(DeliveryModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  String? ownerid;
  String? orderid;

  @override
  void onInit() {
    var arg = Get.arguments;
    if (arg != null) {
      ownerid = arg['ownerid'];
      orderid = arg['orderid'];
    }
    connectToWebSocket();
    getdata();
    // getCurrentLocation();
    startCheckingInactiveDeliveries();
    super.onInit();
  }

  @override
  void onClose() {
    socketService!.disconnect();
    super.onClose();
  }
}
