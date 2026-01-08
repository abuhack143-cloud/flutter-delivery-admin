class CityClassificationModel {
  int? classificationId;
  String? classification;

  CityClassificationModel({this.classificationId, this.classification});

  CityClassificationModel.fromJson(Map<String, dynamic> json) {
    classificationId = json['Classification_id'];
    classification = json['Classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Classification_id'] = classificationId;
    data['Classification'] = classification;
    return data;
  }
}
