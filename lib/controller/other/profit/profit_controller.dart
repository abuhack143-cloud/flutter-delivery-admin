import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/profit.dart';
import 'package:admin/data/model/profitModel.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class ProfitControllerImp extends GetxController {
  late TextEditingController profitText;
  double? doublerofit;
  StatusRequest statusRequest = StatusRequest.none;
  List<ProfitModel> data = [];

  ProfitData profit = ProfitData(Get.find());

  Future<void> profitData() async {
    data.clear();
    var response = await profit.getProfit();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => ProfitModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(ProfitModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> editProfit(String id) async {
    doublerofit = double.tryParse(profitText.text)! / 100;
    data.clear();
    var response = await profit.editProfit(
      id,
      doublerofit.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(doublerofit);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        profitData();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    profitText = TextEditingController();
    profitData();
    super.onInit();
  }
}
