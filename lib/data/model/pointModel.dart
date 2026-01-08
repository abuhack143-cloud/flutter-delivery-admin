class PointModel {
  int? pointId;
  int? pointCity;
  String? point;
  String? pointLocations;
  String? pointTime;
  String? pointDetail;
  String? pointMaps;
  int? cityId;
  String? cityPlate;
  String? cityName;
  int? cityClassification;
  String? cityPrice;

  PointModel(
      {this.pointId,
      this.pointCity,
      this.point,
      this.pointLocations,
      this.pointTime,
      this.pointDetail,
      this.pointMaps,
      this.cityId,
      this.cityPlate,
      this.cityName,
      this.cityClassification,
      this.cityPrice});

  PointModel.fromJson(Map<String, dynamic> json) {
    pointId = json['point_id'];
    pointCity = json['point_city'];
    point = json['point'];
    pointLocations = json['point_locations'];
    pointTime = json['point_time'];
    pointDetail = json['point_detail'];
    pointMaps = json['point_maps'];
    cityId = json['City_id'];
    cityPlate = json['City_Plate'];
    cityName = json['City_name'];
    cityClassification = json['City_Classification'];
    cityPrice = json['City_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['point_id'] = pointId;
    data['point_city'] = pointCity;
    data['point'] = point;
    data['point_locations'] = pointLocations;
    data['point_time'] = pointTime;
    data['point_detail'] = pointDetail;
    data['point_maps'] = pointMaps;
    data['City_id'] = cityId;
    data['City_Plate'] = cityPlate;
    data['City_name'] = cityName;
    data['City_Classification'] = cityClassification;
    data['City_price'] = cityPrice;
    return data;
  }
}