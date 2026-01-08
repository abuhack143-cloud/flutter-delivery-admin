class Cate3Model {
  int? cate3Id;
  String? cate3Name;
  int? categories2;

  Cate3Model({this.cate3Id, this.cate3Name, this.categories2});

  Cate3Model.fromJson(Map<String, dynamic> json) {
    cate3Id = json['cate3_id'];
    cate3Name = json['cate3_name'];
    categories2 = json['categories2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cate3_id'] = cate3Id;
    data['cate3_name'] = cate3Name;
    data['categories2'] = categories2;
    return data;
  }
}
