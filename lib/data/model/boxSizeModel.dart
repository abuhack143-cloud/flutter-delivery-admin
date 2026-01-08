class BoxSizeModel {
  int? boxId;
  String? boxSize;
  int? boxWidth;
  int? boxHeight;
  int? boxLength;
  int? boxWeight;
  int? boxPrice;

  BoxSizeModel(
      {this.boxId,
      this.boxSize,
      this.boxWidth,
      this.boxHeight,
      this.boxLength,
      this.boxWeight,
      this.boxPrice});

  BoxSizeModel.fromJson(Map<String, dynamic> json) {
    boxId = json['box_id'];
    boxSize = json['box_size'];
    boxWidth = json['box_width'];
    boxHeight = json['box_height'];
    boxLength = json['box_length'];
    boxWeight = json['box_weight'];
    boxPrice = json['box_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['box_id'] = boxId;
    data['box_size'] = boxSize;
    data['box_width'] = boxWidth;
    data['box_height'] = boxHeight;
    data['box_length'] = boxLength;
    data['box_weight'] = boxWeight;
    data['box_price'] = boxPrice;
    return data;
  }
}