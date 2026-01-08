class StreetModel {
  int? streetId;
  int? streetNumber;
  String? streetName;
  String? streetPrice;
  int? streetCity;
  int? cityId;
  String? cityPlate;
  String? cityName;
  int? cityClassification;
  String? cityPrice;

  StreetModel(
      {this.streetId,
      this.streetNumber,
      this.streetName,
      this.streetPrice,
      this.streetCity,
      this.cityId,
      this.cityPlate,
      this.cityName,
      this.cityClassification,
      this.cityPrice});

  StreetModel.fromJson(Map<String, dynamic> json) {
    streetId = json['street_id'];
    streetNumber = json['street_number'];
    streetName = json['street_name'];
    streetPrice = json['street_price'];
    streetCity = json['street_city'];
    cityId = json['City_id'];
    cityPlate = json['City_Plate'];
    cityName = json['City_name'];
    cityClassification = json['City_Classification'];
    cityPrice = json['City_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street_id'] = streetId;
    data['street_number'] = streetNumber;
    data['street_name'] = streetName;
    data['street_price'] = streetPrice;
    data['street_city'] = streetCity;
    data['City_id'] = cityId;
    data['City_Plate'] = cityPlate;
    data['City_name'] = cityName;
    data['City_Classification'] = cityClassification;
    data['City_price'] = cityPrice;
    return data;
  }
}
