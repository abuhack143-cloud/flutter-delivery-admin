import 'dart:async';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/order/pendingOrderCustommer/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/WebSocketService.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/map.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  bool info = false;

  // Completer<GoogleMapController>? completercontroller;
  Position? position;

  // CameraPosition? kGooglePlex;

  final List<Map<String, dynamic>> locations = [];
  final List<Marker> markers = [];

  WebSocketService? socketService;
  List<StoreOwnerModel> data = [];
  List<DeliveryModel> data1 = [];
  List<StoreOwnerModel> data2 = [];

  MapData mapData = MapData(Get.find());

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

        if (location['type'] == 'storeOwner' &&
            Get.find<HomeControllerImp>().role != "admin_other") {
          PaintImage paintImage = PaintImage();
          BitmapDescriptor customIcon = await paintImage.getMarkerIconFromUrl(
            location['image'],
            "images/marker_owner.png",
          );
          final markerId = MarkerId("${location['user_id']}");
          final marker = Marker(
            markerId: markerId,
            position: LatLng(location['latitude'], location['longitude']),
            icon: customIcon,
            onTap: () {
              info = true;
              id = location['user_id'];
              getStoreOwner(location['user_id']);
              update();
            },
          );
          markers.add(marker);
          update();
        }

        if (location['type'] == 'delivery' &&
            Get.find<HomeControllerImp>().role != "admin_other") {
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
              id = location['user_id'];
              getdelivery(id.toString());
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

  Future<void> getdata() async {
    data.clear();
    var response = await mapData.getData();

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
              onTap: () {
                id = item.ownerId.toString();
                getStoreOwner(item.ownerId.toString());
                info = true;
                update();
              },
            );
            markers.add(marker);
          } else {}
        },
      ).toSet();
    }

    update();
  }

  String? id;

  Future<void> getdelivery(String id) async {
    data1.clear();
    data2.clear();
    var response = await mapData.deliveryData(id);

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

  Future<void> getStoreOwner(String id) async {
    data2.clear();
    data1.clear();
    var response = await mapData.storeOwnerData(id);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data2.addAll(responseData.map((e) => StoreOwnerModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data2.add(StoreOwnerModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  Future<void> getCurrentLocation() async {
    try {
      position = await Geolocator.getCurrentPosition();
      // if (position != null) {
      //   kGooglePlex = CameraPosition(
      //     target: LatLng(position!.latitude, position!.longitude),
      //     zoom: 5.4746,
      //   );
      // }
      statusRequest = StatusRequest.none;
    } catch (e) {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  void onInit() {
    if (Get.find<HomeControllerImp>().role != "admin_other") {
      connectToWebSocket();
      getdata();
      getCurrentLocation();
    }

    super.onInit();
  }

  @override
  void onClose() {
    socketService!.disconnect();
    super.onClose();
  }
}
