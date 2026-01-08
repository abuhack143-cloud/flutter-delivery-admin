import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class CollectionPointData {
  Crud crud;
  CollectionPointData(this.crud);

  Future getCollectionPoint() async {
    var response = await crud.postData(AppLink.collectionPoint, {});
    return response.fold((l) => l, (r) => r);
  }

  Future deleteCollectionPoint(String id) async {
    var response =
        await crud.postData(AppLink.deletecollectionPoint, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editCollectionPoint(
    String id,
    String pointCity,
    String point,
    String pointlocations,
    String pointTime,
    String pointDetail,
    String pointMaps,
  ) async {
    var response = await crud.postData(
      AppLink.editcollectionPoint,
      {
        "id": id,
        "point_city": pointCity,
        "point": point,
        "point_locations": pointlocations,
        "point_time": pointTime,
        "point_detail": pointDetail,
        "point_maps": pointMaps,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future getCity() async {
    var response = await crud.postData(AppLink.cityCollection, {});
    return response.fold((l) => l, (r) => r);
  }

  Future addCollectionPoint(
    String pointCity,
    String point,
    String pointlocations,
    String pointTime,
    String pointDetail,
    String pointMaps,
  ) async {
    var response = await crud.postData(
      AppLink.addcollectionPoint,
      {
        "point_city": pointCity,
        "point": point,
        "point_locations": pointlocations,
        "point_time": pointTime,
        "point_detail": pointDetail,
        "point_maps": pointMaps,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
