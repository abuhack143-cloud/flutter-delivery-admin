import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class ReportData {
  Crud crud;
  ReportData(this.crud);

  Future getReport(int offset, int limit) async {
    var response = await crud.postData(
      AppLink.report,
      {
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future deleteReport(
    String id,
  ) async {
    var response = await crud.postData(
      AppLink.deleteReport,
      {
        "id": id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
