import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/order/deliveryFail.dart';
import 'package:admin/data/datasource/remote/order/order.dart';
import 'package:admin/data/datasource/remote/order/orderCustommer.dart';
import 'package:admin/data/datasource/remote/order/pending2.dart';
import 'package:admin/data/datasource/remote/order/storage.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:get/get.dart';

class DeliveryPendingControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  List<DeliveryModel> data = [];

  Pending2Data pending2data = Pending2Data(Get.find());

  OrderData orderData = OrderData(Get.find());

  MyServices myServices = Get.find();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  Future<void> getdata() async {
    data.clear();

    var response = await pending2data.deliveryData();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => DeliveryModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(DeliveryModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  DeliveryfailData deliveryfailData = DeliveryfailData(Get.find());
  OrderCustommerData orderCustommerData = OrderCustommerData(Get.find());
  StorageData storageData = StorageData(Get.find());
  Future<void> approveOrders(String deliveryid) async {
    var response;
    if (page == "pending2") {
      response = await pending2data.approve2Order(orderid.toString(),
          deliveryid.toString(), ownerid.toString(), orderNumber.toString());
    }
    if (page == "city") {
      response = await orderData.approve2CityOrder(
        orderid.toString(),
        deliveryid.toString(),
        ownerid.toString(),
      );
    }
    if (page == "deliveryFail") {
      response = await deliveryfailData.approveOrder(
        orderid.toString(),
        deliveryid.toString(),
        orderNumber.toString(),
      );
    }
    if (page == "storage") {
      response = await storageData.approve2Order(
        orderid.toString(),
        deliveryid.toString(),
        orderNumber.toString(),
      );
    }

    // var response = await pending2data.approve2Order(orderid.toString(),
    //     deliveryid.toString(), ownerid.toString(), orderNumber.toString());
    response;
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: "refresh");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  String? orderid;
  String? ownerid;
  String? orderNumber;
  String? page;
  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;
    if (arg != null) {
      orderid = arg["orderid"];
      ownerid = arg["ownerid"];
      orderNumber = arg["orderNumber"];
      page = arg["page"];
    }

    getdata();
  }
}
