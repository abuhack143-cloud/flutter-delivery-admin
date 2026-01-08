import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:admin/data/model/cate2Model.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCategories3ControllerImp extends GetxController {
  String? theCate;
  String? id;
  String? cate1;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cateName;

  StatusRequest statusRequest = StatusRequest.loading;

  CategoriesData categoriesdata = CategoriesData(Get.find());

  List<SelectedListItem> cate2 = [];
  List<String> listCate2 = [];
  String stringcate2 = '';
  List<Cate2Model> dataCate2 = [];

  bool isClassError = false;

  Future<void> cateData() async {
    dataCate2.clear();
    var response = await categoriesdata.getCategories2(cate1.toString());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataCate2.addAll(responseData.map((e) => Cate2Model.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataCate2.add(Cate2Model.fromJson(mapData));
        }

        if (dataCate2.isNotEmpty) {
          cate2 = dataCate2
              .map((item) => SelectedListItem(
                  data: "${item.cate2Name}", value: "${item.cate2Id}"))
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
      stringcate2.toString(),
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
      cate1 = arg['cate1'];
      cateName.text = arg['cate3'];
      theCate = arg['cate3'];
      stringcate2 = arg['cate2'];
      listCate2 = [arg['cate2']];
    }
    cateData();
    super.onInit();
  }
}
