class OrderCityModel {
  int? cityId;
  String? cityPlate;
  String? cityName;
  int? cityClassification;
  String? cityPrice;
  int? classificationId;
  String? classification;

  OrderCityModel(
      {this.cityId,
      this.cityPlate,
      this.cityName,
      this.cityClassification,
      this.cityPrice,
      this.classificationId,
      this.classification});

  OrderCityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['City_id'];
    cityPlate = json['City_Plate'];
    cityName = json['City_name'];
    cityClassification = json['City_Classification'];
    cityPrice = json['City_price'];
    classificationId = json['Classification_id'];
    classification = json['Classification'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['City_id'] = cityId;
    data['City_Plate'] = cityPlate;
    data['City_name'] = cityName;
    data['City_Classification'] = cityClassification;
    data['City_price'] = cityPrice;
    data['Classification_id'] = classificationId;
    data['Classification'] = classification;
    return data;
  }
}
