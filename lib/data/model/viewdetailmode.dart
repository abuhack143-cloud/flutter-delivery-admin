class Detailmodel {
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
  int? addressId;
  int? addressuser;
  String? addressCity;
  String? addressStreet;
  String? addressLocation;
  double? addressLat;
  double? addressLong;
  int? addressKey;
  int? detailId;
  int? detailNumber;
  int? detailBox;
  String? detailCanOpened;
  String? detailReturn;
  String? detailPayment;
  String? detail50;
  int? detailKey;
  int? ownerId;
  String? ownerName;
  String? ownerEmail;
  String? ownerPassword;
  String? ownerProfile;
  int? ownerApprove;
  String? ownerPhone1;
  String? ownerPhone2;
  String? ownerWhatsApp;
  String? ownerNationalID;
  String? ownerPassportNumber;
  String? ownerIDCardNumber;
  String? ownerPassportPic;
  int? ownerCity;
  int? ownerStreet;
  double? ownerLat;
  double? ownerLng;
  int? ownerVerfiycode;
  int? cityId;
  String? cityPlate;
  String? cityName;
  int? cityClassification;
  String? cityPrice;
  int? streetId;
  int? streetNumber;
  String? streetName;
  int? streetCity;

  Detailmodel(
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
      this.addressId,
      this.addressuser,
      this.addressCity,
      this.addressStreet,
      this.addressLocation,
      this.addressLat,
      this.addressLong,
      this.addressKey,
      this.detailId,
      this.detailNumber,
      this.detailBox,
      this.detailCanOpened,
      this.detailReturn,
      this.detailPayment,
      this.detail50,
      this.detailKey,
      this.ownerId,
      this.ownerName,
      this.ownerEmail,
      this.ownerPassword,
      this.ownerProfile,
      this.ownerApprove,
      this.ownerPhone1,
      this.ownerPhone2,
      this.ownerWhatsApp,
      this.ownerNationalID,
      this.ownerPassportNumber,
      this.ownerIDCardNumber,
      this.ownerPassportPic,
      this.ownerCity,
      this.ownerStreet,
      this.ownerLat,
      this.ownerLng,
      this.ownerVerfiycode,
      this.cityId,
      this.cityPlate,
      this.cityName,
      this.cityClassification,
      this.cityPrice,
      this.streetId,
      this.streetNumber,
      this.streetName,
      this.streetCity});

  Detailmodel.fromJson(Map<String, dynamic> json) {
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
    addressId = json['addressId'];
    addressuser = json['addressuser'];
    addressCity = json['addressCity'];
    addressStreet = json['addressStreet'];
    addressLocation = json['addressLocation'];
    addressLat = json['addressLat'];
    addressLong = json['addressLong'];
    addressKey = json['addressKey'];
    detailId = json['detail_id'];
    detailNumber = json['detail_number'];
    detailBox = json['detail_box'];
    detailCanOpened = json['detail_canOpened'];
    detailReturn = json['detail_return'];
    detailPayment = json['detail_payment'];
    detail50 = json['detail_50'];
    detailKey = json['detail_key'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    ownerEmail = json['owner_email'];
    ownerPassword = json['owner_password'];
    ownerProfile = json['owner_profile'];
    ownerApprove = json['owner_approve'];
    ownerPhone1 = json['owner_phone1'];
    ownerPhone2 = json['owner_phone2'];
    ownerWhatsApp = json['owner_whatsApp'];
    ownerNationalID = json['owner_NationalID'];
    ownerPassportNumber = json['owner_PassportNumber'];
    ownerIDCardNumber = json['owner_IDCardNumber'];
    ownerPassportPic = json['owner_passportPic'];
    ownerCity = json['owner_city'];
    ownerStreet = json['owner_street'];
    ownerLat = json['owner_lat'];
    ownerLng = json['owner_lng'];
    ownerVerfiycode = json['owner_verfiycode'];
    cityId = json['City_id'];
    cityPlate = json['City_Plate'];
    cityName = json['City_name'];
    cityClassification = json['City_Classification'];
    cityPrice = json['City_price'];
    streetId = json['street_id'];
    streetNumber = json['street_number'];
    streetName = json['street_name'];
    streetCity = json['street_city'];
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
    data['addressId'] = addressId;
    data['addressuser'] = addressuser;
    data['addressCity'] = addressCity;
    data['addressStreet'] = addressStreet;
    data['addressLocation'] = addressLocation;
    data['addressLat'] = addressLat;
    data['addressLong'] = addressLong;
    data['addressKey'] = addressKey;
    data['detail_id'] = detailId;
    data['detail_number'] = detailNumber;
    data['detail_box'] = detailBox;
    data['detail_canOpened'] = detailCanOpened;
    data['detail_return'] = detailReturn;
    data['detail_payment'] = detailPayment;
    data['detail_50'] = detail50;
    data['detail_key'] = detailKey;
    data['owner_id'] = ownerId;
    data['owner_name'] = ownerName;
    data['owner_email'] = ownerEmail;
    data['owner_password'] = ownerPassword;
    data['owner_profile'] = ownerProfile;
    data['owner_approve'] = ownerApprove;
    data['owner_phone1'] = ownerPhone1;
    data['owner_phone2'] = ownerPhone2;
    data['owner_whatsApp'] = ownerWhatsApp;
    data['owner_NationalID'] = ownerNationalID;
    data['owner_PassportNumber'] = ownerPassportNumber;
    data['owner_IDCardNumber'] = ownerIDCardNumber;
    data['owner_passportPic'] = ownerPassportPic;
    data['owner_city'] = ownerCity;
    data['owner_street'] = ownerStreet;
    data['owner_lat'] = ownerLat;
    data['owner_lng'] = ownerLng;
    data['owner_verfiycode'] = ownerVerfiycode;
    data['City_id'] = cityId;
    data['City_Plate'] = cityPlate;
    data['City_name'] = cityName;
    data['City_Classification'] = cityClassification;
    data['City_price'] = cityPrice;
    data['street_id'] = streetId;
    data['street_number'] = streetNumber;
    data['street_name'] = streetName;
    data['street_city'] = streetCity;
    return data;
  }
}
