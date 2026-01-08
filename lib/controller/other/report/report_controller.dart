import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/report.dart';
import 'package:admin/data/model/reportModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  ReportData reportData = ReportData(Get.find());

  List<ReportModel> data = [];

  int currentPage = 0;
  int pageSize = 20;
  bool hasMoreData = true;
  final ScrollController scrollController = ScrollController();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await reportdata();
    update();
  }

  void deleteButton(int index) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'warining'.tr,
      desc: "Are you sure you want Accept order".tr,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        deleteReport(data[index].reportId.toString());
      },
    ).show();
  }

  Future<void> deleteReport(String id) async {
    var response = await reportData.deleteReport(id);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        reportdata();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> reportdata({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear();
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await reportData.getReport(currentPage, pageSize);
    print(response);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          List<ReportModel> newReportData =
              responseData.map((e) => ReportModel.fromJson(e)).toList();

          if (newReportData.length < pageSize) {
            hasMoreData = false; // لا توجد بيانات إضافية
          }

          data.addAll(newReportData);

          currentPage += pageSize;
        }
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    reportdata();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        reportdata(isLoadMore: true);
      }
    });
    super.onInit();
  }
}
