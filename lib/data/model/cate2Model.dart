class Cate2Model {
  int? cate2Id;
  String? cate2Name;
  int? categories1;

  Cate2Model({this.cate2Id, this.cate2Name, this.categories1});

  Cate2Model.fromJson(Map<String, dynamic> json) {
    cate2Id = json['cate2_id'];
    cate2Name = json['cate2_name'];
    categories1 = json['categories1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cate2_id'] = cate2Id;
    data['cate2_name'] = cate2Name;
    data['categories1'] = categories1;
    return data;
  }
}