import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class CategoriesData {
  Crud crud;
  CategoriesData(this.crud);

  //Cate1
  Future getCategories1() async {
    var response = await crud.postData(AppLink.cate1, {});
    return response.fold((l) => l, (r) => r);
  }

  Future searchCategories1(String search) async {
    var response = await crud.postData(AppLink.searchCate1, {"search": search});
    return response.fold((l) => l, (r) => r);
  }

  Future addCategories1(String cate1Name) async {
    var response =
        await crud.postData(AppLink.addCate1, {"cate1Name": cate1Name});
    return response.fold((l) => l, (r) => r);
  }

  Future deleteCategories1(List<String> id) async {
    var response = await crud.postData(AppLink.deleteCate1, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editCategories1(String id, String cate1Name) async {
    var response = await crud.postData(AppLink.editCate1,
        {"id": id.toString(), "cate1Name": cate1Name.toString()});
    return response.fold((l) => l, (r) => r);
  }

//Cate2
  Future getCategories2(String id) async {
    var response = await crud.postData(AppLink.cate2, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future searchCategories2(String search) async {
    var response = await crud.postData(AppLink.searchCate2, {"search": search});
    return response.fold((l) => l, (r) => r);
  }

  Future addCategories2(String cate1, String cate2Name) async {
    var response = await crud.postData(
      AppLink.addCate2,
      {
        "cate1": cate1,
        "cate2Name": cate2Name,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future deleteCategories2(List<String> id) async {
    var response = await crud.postData(AppLink.deleteCate2, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editCategories2(String id, String cate1, String cate2Name) async {
    var response = await crud.postData(
        AppLink.editCate2, {"id": id, "cate1": cate1, "cate2Name": cate2Name});
    return response.fold((l) => l, (r) => r);
  }

  //Cate3
  Future getCategories3(String id) async {
    var response = await crud.postData(AppLink.cate3, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future searchCategories3(String search) async {
    var response = await crud.postData(AppLink.searchCate3, {"search": search});
    return response.fold((l) => l, (r) => r);
  }

  Future addCategories3(String cate3Name, String cate2) async {
    var response = await crud.postData(
      AppLink.addCate3,
      {
        "cate3Name": cate3Name,
        "cate2": cate2,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future deleteCategories3(List<String> id) async {
    var response = await crud.postData(AppLink.deleteCate3, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editCategories3(String id, String cate2, String cate3Name) async {
    var response = await crud.postData(
      AppLink.editCate3,
      {
        "id": id,
        "cate2": cate2,
        "cate3Name": cate3Name,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
