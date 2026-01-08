class ProfitModel {
  int? profitId;
  String? profit;

  ProfitModel({this.profit});

  ProfitModel.fromJson(Map<String, dynamic> json) {
    profitId = json['profit_id'];
    profit = json['profit_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profit_id'] = profitId;
    data['profit_percentage'] = profit;
    return data;
  }
}
