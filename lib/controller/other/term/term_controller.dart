import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/term.dart';
import 'package:admin/data/model/termModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TermController extends GetxController {
  late TextEditingController termText;

  TermData termdata = TermData(Get.find());

  List<TermModel> data = [];

  StatusRequest statusRequest = StatusRequest.none;

  String? id;

  bool border = false;

  Future<void> termData() async {
    var response = await termdata.getTerm();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => TermModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(TermModel.fromJson(mapData));
        }
        termText.clear();
        update();
        if (data.isNotEmpty) {
          termText.text = data[0].term.toString();
          id = data[0].termId.toString();
          update();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> editTerm() async {
    var response = await termdata.editTerm(
      id.toString(),
      termText.text.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    termText = TextEditingController();
    termData();
    update();
    super.onInit();
  }
}
