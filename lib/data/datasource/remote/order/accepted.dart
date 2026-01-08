import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class OrderAcceptedData {
  Crud crud;

  OrderAcceptedData(this.crud);

  Future statusData() async {
    var response = await crud.postData(AppLink.status, {});
    return response.fold((l) => l, (r) => r);
  }

  Future searchData(String text, String option) async {
    var response = await crud.postData(
      AppLink.search,
      {
        "search": text,
        "option": option,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future getData(
    String status,
  ) async {
    var response = await crud.postData(
      AppLink.result,
      {
        "status": status,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
