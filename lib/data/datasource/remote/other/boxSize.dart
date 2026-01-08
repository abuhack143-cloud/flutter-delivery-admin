import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class BoxSizeData {
  Crud crud;
  BoxSizeData(this.crud);

  Future getBoxSize() async {
    var response = await crud.postData(AppLink.boxSize, {});
    return response.fold((l) => l, (r) => r);
  }

  Future deleteBoxSize(String id) async {
    var response = await crud.postData(AppLink.deleteBoxSize, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editBoxSize(
    String id,
    String size,
    String width,
    String length,
    String height,
    String weight,
    String price,
  ) async {
    var response = await crud.postData(
      AppLink.editBoxSize,
      {
        "id": id,
        "size": size,
        "width": width,
        "length": length,
        "height": height,
        "weight": weight,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future addBoxSize(
    String size,
    String width,
    String length,
    String height,
    String weight,
    String price,
  ) async {
    var response = await crud.postData(
      AppLink.addBoxSize,
      {
        "size": size,
        "width": width,
        "length": length,
        "height": height,
        "weight": weight,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
