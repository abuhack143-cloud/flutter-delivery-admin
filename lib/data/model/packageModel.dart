class PackagingModel {
  int? packagingId;
  String? packagingPackaging;
  String? packagingPrice;

  PackagingModel(
      {this.packagingId, this.packagingPackaging, this.packagingPrice});

  PackagingModel.fromJson(Map<String, dynamic> json) {
    packagingId = json['packaging_id'];
    packagingPackaging = json['packaging_packaging'];
    packagingPrice = json['packaging_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packaging_id'] = packagingId;
    data['packaging_packaging'] = packagingPackaging;
    data['packaging_price'] = packagingPrice;
    return data;
  }
}
