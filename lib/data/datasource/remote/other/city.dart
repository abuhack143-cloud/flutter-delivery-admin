import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class CityData {
  Crud crud;
  CityData(this.crud);

  Future getCity(List<String> classification) async {
    var response = await crud
        .postData(AppLink.cityOther, {"classification": classification});
    return response.fold((l) => l, (r) => r);
  }

  Future getClass() async {
    var response = await crud.postData(AppLink.classification, {});
    return response.fold((l) => l, (r) => r);
  }

  Future addCity(
      String city, String classification, String plate, String price) async {
    var response = await crud.postData(
      AppLink.addCity,
      {
        'city': city,
        'classification': classification,
        'plate': plate,
        'price': price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future deleteCity(List<String> id) async {
    var response = await crud.postData(
      AppLink.deleteCity,
      {
        'id': id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future editCity(String id, String classification, String city, String price,
      String plate) async {
    var response = await crud.postData(
      AppLink.editCity,
      {
        "id": id,
        "classification": classification,
        "city": city,
        "price": price,
        "plate": plate,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
