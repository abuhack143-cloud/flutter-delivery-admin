import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class ProfitData {
  Crud crud;
  ProfitData(this.crud);

  Future getProfit() async {
    var response = await crud.postData(AppLink.profit, {});
    return response.fold((l) => l, (r) => r);
  }

  Future editProfit(String id, String profit) async {
    var response = await crud.postData(
      AppLink.editProfit,
      {
        "id": id,
        "profit": profit,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
