import 'package:admin/data/datasource/remote/order/accepted.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class OrderStatusControllerImp extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;
  CameraFacing cameraFacing = CameraFacing.back;
  QrScannerOverlayShape? overlay =
      QrScannerOverlayShape(borderColor: Appcolor.primary);
  void onQRViewCreated(QRViewController qrController) {
    this.qrController = qrController;
    qrController.scannedDataStream.listen((scanData) {
      result = scanData;
      Get.toNamed(AppRoute.search, arguments: {
        "text": result!.code,
        "title": "All",
        "value": "All",
      });
      update();
    });
  }

  late TextEditingController search;

  OrderAcceptedData orderAcceptedsData = OrderAcceptedData(Get.find());
  String? username;
  String? id;
  String? orderid;

  StatusRequest statusRequest = StatusRequest.none;

  int? notApprovedCount;
  int? approvedCount;
  int? received;
  int? city;
  int? delivered;
  int? fail;
  int? deliveryAccept;
  int? deliveryToAdmin;
  int? deliveryToCustomer;
  int? deliveredNoCity;

  Future<void> orderStatus() async {
    var response = await orderAcceptedsData.statusData();
    statusRequest = StatusRequest.loading;
    update();

    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        notApprovedCount = response['notApprove'];
        approvedCount = response['Approve'];
        deliveryAccept = response['DeliveryAccept'];
        received = response['received'];
        deliveryToAdmin = response['deliveryToAdmin'];
        deliveryToCustomer = response['deliveryToCustomer'];
        deliveredNoCity = response['deliveredNoCity'];
        city = response['city'];
        delivered = response['delivered'];
        fail = response['fail'];
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  MyServices myServices = Get.find();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();

    await orderStatus();
  }

  void initialData() {
    username = myServices.sharedPreferences.getString('username');
    id = myServices.sharedPreferences.getString('id');
  }

  @override
  void onInit() {
    search = TextEditingController();
    orderStatus();
    super.onInit();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
