class Cate1Model {
  int? cate1Id;
  String? cate1Name;

  Cate1Model({this.cate1Id, this.cate1Name});

  Cate1Model.fromJson(Map<String, dynamic> json) {
    cate1Id = json['cate1_id'];
    cate1Name = json['cate1_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cate1_id'] = cate1Id;
    data['cate1_name'] = cate1Name;
    return data;
  }
}
