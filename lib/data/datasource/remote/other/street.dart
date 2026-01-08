import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class StreetData {
  Crud crud;
  StreetData(this.crud);

  getCityStreet() async {
    var response = await crud.postData(AppLink.cityStreet, {});
    return response.fold((l) => l, (r) => r);
  }

  getCity() async {
    var response = await crud.postData(AppLink.cityS, {});
    return response.fold((l) => l, (r) => r);
  }

  getStreet(List<String> city, int offset, int limit) async {
    var response = await crud.postData(
      AppLink.street,
      {
        "cities": city,
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  addStreet(String city, String street, String number, String price) async {
    var response = await crud.postData(
      AppLink.addStreet,
      {
        "city": city,
        "street": street,
        "number": number,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  editStreet(String id, String city, String street, String number,
      String price) async {
    var response = await crud.postData(
      AppLink.editStreet,
      {
        "id": id,
        "city": city,
        "street": street,
        "number": number,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  deleteStreet(
    List<String> id,
  ) async {
    var response = await crud.postData(
      AppLink.deleteStreet,
      {
        "id": id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
