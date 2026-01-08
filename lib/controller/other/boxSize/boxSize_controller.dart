import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/boxSize.dart';
import 'package:admin/data/model/boxSizeModel.dart';
import 'package:get/get.dart';

class BoxsizeControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  List<BoxSizeModel> data = [];

  BoxSizeData boxData = BoxSizeData(Get.find());

  Future<void> onRefresh() async {
    statusRequest = StatusRequest.loading;
    update();
    await boxSizeData();
  }

  Future<void> boxSizeData() async {
    data.clear();
    var response = await boxData.getBoxSize();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => BoxSizeModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(BoxSizeModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deleteBoxSizeData(String id) async {
    var response = await boxData.deleteBoxSize(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        boxSizeData();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addboxsize);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await boxSizeData();
    }
  }

  Future<void> navigateEditPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.editboxsize, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await boxSizeData();
    }
  }

  @override
  void onInit() {
    boxSizeData();
    super.onInit();
  }
}
