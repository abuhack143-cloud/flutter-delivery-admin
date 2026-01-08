class TermModel {
  int? termId;
  String? term;

  TermModel({this.termId, this.term});

  TermModel.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    term = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['terms'] = term;
    return data;
  }
}
