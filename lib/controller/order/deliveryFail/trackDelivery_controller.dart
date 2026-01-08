import 'dart:async';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/WebSocketService.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/order/deliveryFail.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TrackDeliveryFailControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  bool info = false;
  HomeControllerImp mapController = Get.find();
  Position? position;

  final List<Map<String, dynamic>> locations = [];
  final Set<Marker> markers = {};

  WebSocketService? socketService;
  List<StoreOwnerModel> data = [];
  List<DeliveryModel> data1 = [];

  DeliveryfailData orderData = DeliveryfailData(Get.find());
  final Map<String, DateTime> lastUpdateTimes = {};
  void connectToWebSocket() {
    socketService = WebSocketService();
    if (socketService == null) return;

    socketService!.connect();

    socketService!.onLocationReceived = (location) async {
      final userId = location['user_id'].toString();
      lastUpdateTimes[userId] = DateTime.now();
      final exists = locations.any((existingLocation) =>
          existingLocation['user_id'] == location['user_id'] &&
          existingLocation['latitude'] == location['latitude'] &&
          existingLocation['longitude'] == location['longitude'] &&
          existingLocation['image'] == location['image']);

      if (!exists) {
        locations.add(location);

        if (location['type'] == 'delivery' &&
            location['user_id'] == deliveryid3) {
          BitmapDescriptor customIcon = await getMarkerIconFromUrl(
              location['image']);
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
          mapController.kGooglePlex = CameraPosition(
            target: LatLng(location['latitude'], location['longitude']),
            zoom: 10.4746,
          );
          update();
        }

        if (location['type'] == 'delivery' &&
            location['user_id'] == deliveryid) {
          // ignore: deprecated_member_use
          BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50, 50)),
            'images/marker_blue.png',
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

  Future<BitmapDescriptor> getMarkerIconFromUrl(String imageUrl) async {
    try {
      // تحميل صورة الدليفري من URL
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) throw Exception("Failed to load image");
      Uint8List imageData = response.bodyBytes;

      // تحميل أيقونة الماركر الافتراضية (الحمراء)
      ByteData data =
          await rootBundle.load("images/marker_red.png"); // أضف صورة ماركر هنا
      Uint8List markerBytes = data.buffer.asUint8List();

      // تحويل صورتي الدليفري والماركر إلى ui.Image
      final ui.Codec markerCodec = await ui.instantiateImageCodec(
        markerBytes,
        targetWidth: 150,
      );
      final ui.FrameInfo markerFrameInfo = await markerCodec.getNextFrame();
      final ui.Image markerImage = markerFrameInfo.image;

      final ui.Codec deliveryCodec =
          await ui.instantiateImageCodec(imageData, targetWidth: 60);
      final ui.FrameInfo deliveryFrameInfo = await deliveryCodec.getNextFrame();
      final ui.Image deliveryImage = deliveryFrameInfo.image;

      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      const double size = 200;
      canvas.save();
      canvas.translate(size / 2, size / 2);
      canvas.rotate(3.1416); // 180 درجة (π radians)
      canvas.translate(-size / 2, -size / 2);

      // رسم أيقونة الماركر الأحمر كخلفية
      paintImage(
        canvas: canvas,
        rect: const Rect.fromLTWH(0, 0, size, size),
        image: markerImage,
        fit: BoxFit.cover,
      );
      canvas.restore();
      // رسم صورة الدليفري داخل دائرة في منتصف الماركر
      const double circleSize = 70;
      const double dy = 20; // تحريك الصورة قليلاً للأعلى داخل الماركر
      canvas.save();
      canvas.translate(size / 2, size / 2);
      canvas.rotate(3.1416); // 180 درجة (π radians)
      canvas.translate(-size / 2, -size / 2);
      final Paint circlePaint = Paint()..isAntiAlias = true;
      canvas.drawCircle(const Offset(size / 2, dy + (circleSize / 2)),
          circleSize / 2, circlePaint);

      paintImage(
        canvas: canvas,
        rect: Rect.fromCircle(
            center: const Offset(size / 2, dy + (circleSize / 2)),
            radius: circleSize / 2),
        image: deliveryImage,
        fit: BoxFit.cover,
      );
      canvas.restore();
      final ui.Image finalImage =
          await recorder.endRecording().toImage(size.toInt(), size.toInt());
      final ByteData? byteData =
          await finalImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List finalMarkerBytes = byteData!.buffer.asUint8List();

      // ignore: deprecated_member_use
      return BitmapDescriptor.fromBytes(finalMarkerBytes);
    } catch (e) {
      return BitmapDescriptor.defaultMarker;
    }
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

  Future<void> getdelivery(String id) async {
    data1.clear();

    var response = await orderData.deliveryData(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

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

  String? deliveryid;
  String? deliveryid3;

  @override
  void onInit() {
    var arg = Get.arguments;

    if (arg != null) {
      deliveryid = arg['deliveryid'];
      deliveryid3 = arg['deliveryid3'];
    }

    connectToWebSocket();

    startCheckingInactiveDeliveries();
    super.onInit();
  }

  @override
  void onClose() {
    socketService!.disconnect();
    super.onClose();
  }
}
