class OrderModel {
  int? orderId;
  int? orderOwner;
  String? orderCustomerName;
  String? orderName;
  String? orderCustomerPhone;
  int? orderLocation;
  int? orderDetail;
  String? orderDay;
  int? orderPrice;
  String? orderDate;
  int? orderStatus;
  int? orderDelivery;
  String? ordersDatetime;
  String? orderNumber;
  int? detailId;
  int? detailNumber;
  int? detailBox;
  String? detailCanOpened;
  String? detailReturn;
  String? detailPayment;
  String? detail50;
  int? detailKey;
  int? addressId;
  int? addressuser;
  String? addressCity;
  String? addressStreet;
  String? addressLocation;
  double? addressLat;
  double? addressLong;
  int? addressKey;

  OrderModel(
      {this.orderId,
      this.orderOwner,
      this.orderCustomerName,
      this.orderName,
      this.orderCustomerPhone,
      this.orderLocation,
      this.orderDetail,
      this.orderDay,
      this.orderPrice,
      this.orderDate,
      this.orderStatus,
      this.orderDelivery,
      this.ordersDatetime,
      this.orderNumber,
      this.detailId,
      this.detailNumber,
      this.detailBox,
      this.detailCanOpened,
      this.detailReturn,
      this.detailPayment,
      this.detail50,
      this.detailKey,
      this.addressId,
      this.addressuser,
      this.addressCity,
      this.addressStreet,
      this.addressLocation,
      this.addressLat,
      this.addressLong,
      this.addressKey});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderOwner = json['order_owner'];
    orderCustomerName = json['order_customerName'];
    orderName = json['order_name'];
    orderCustomerPhone = json['order_customerPhone'];
    orderLocation = json['order_location'];
    orderDetail = json['order_detail'];
    orderDay = json['order_day'];
    orderPrice = json['order_price'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    orderDelivery = json['order_delivery'];
    ordersDatetime = json['ordersDatetime'];
    orderNumber = json['order_number'];
    detailId = json['detail_id'];
    detailNumber = json['detail_number'];
    detailBox = json['detail_box'];
    detailCanOpened = json['detail_canOpened'];
    detailReturn = json['detail_return'];
    detailPayment = json['detail_payment'];
    detail50 = json['detail_50'];
    detailKey = json['detail_key'];
    addressId = json['addressId'];
    addressuser = json['addressuser'];
    addressCity = json['addressCity'];
    addressStreet = json['addressStreet'];
    addressLocation = json['addressLocation'];
    addressLat = json['addressLat'];
    addressLong = json['addressLong'];
    addressKey = json['addressKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_owner'] = orderOwner;
    data['order_customerName'] = orderCustomerName;
    data['order_name'] = orderName;
    data['order_customerPhone'] = orderCustomerPhone;
    data['order_location'] = orderLocation;
    data['order_detail'] = orderDetail;
    data['order_day'] = orderDay;
    data['order_price'] = orderPrice;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['order_delivery'] = orderDelivery;
    data['ordersDatetime'] = ordersDatetime;
    data['order_number'] = orderNumber;
    data['detail_id'] = detailId;
    data['detail_number'] = detailNumber;
    data['detail_box'] = detailBox;
    data['detail_canOpened'] = detailCanOpened;
    data['detail_return'] = detailReturn;
    data['detail_payment'] = detailPayment;
    data['detail_50'] = detail50;
    data['detail_key'] = detailKey;
    data['addressId'] = addressId;
    data['addressuser'] = addressuser;
    data['addressCity'] = addressCity;
    data['addressStreet'] = addressStreet;
    data['addressLocation'] = addressLocation;
    data['addressLat'] = addressLat;
    data['addressLong'] = addressLong;
    data['addressKey'] = addressKey;
    return data;
  }
}
