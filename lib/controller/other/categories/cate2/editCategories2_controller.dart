import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:admin/data/model/cate1Model.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCategories2ControllerImp extends GetxController {
  String? theCate;
  String? id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cateName;

  StatusRequest statusRequest = StatusRequest.loading;

  CategoriesData categoriesdata = CategoriesData(Get.find());

  List<SelectedListItem> cate1 = [];
  List<String> listCate1 = [];
  String stringcate1 = '';
  String cate1id = '';
  List<Cate1Model> dataCate1 = [];

  bool isClassError = false;

  Future<void> cateData() async {
    dataCate1.clear();
    var response = await categoriesdata.getCategories1();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataCate1.addAll(responseData.map((e) => Cate1Model.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataCate1.add(Cate1Model.fromJson(mapData));
        }

        if (dataCate1.isNotEmpty) {
          cate1 = dataCate1
              .map((item) => SelectedListItem(
                  data: "${item.cate1Name}", value: "${item.cate1Id}"))
              .toList();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> editCate() async {
    var response = await categoriesdata.editCategories2(
      id.toString(),
      stringcate1.toString(),
      cateName.text.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: 'refresh');
      } else {
        Get.back();
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    cateName = TextEditingController();
    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      cateName.text = arg['cate2'];
      theCate = arg['cate2'];
      stringcate1 = arg['cate1'];
      cate1id = arg['cate1id'];
      listCate1 = [arg['cate1']];
    }
    cateData();
    super.onInit();
  }
}
