class OrderModel {
  int? orderId;
  int? orderOwner;
  String? orderCustomerName;
  String? orderName;
  String? orderCustomerPhone;
  int? orderLocation;
  int? orderDetail;
  String? orderDay;
  String? orderPrice;
  String? orderDate;
  int? orderStatus;
  int? orderAdmin;
  int? orderAdminCity;
  int? orderDelivery;
  int? orderDelivery2;
  int? orderDelivery3;
  String? ordersDatetime;
  String? orderNumber;
  int? orderReason;
  int? detailId;
  int? detailNumber;
  int? detailBox;
  String? detailCanOpened;
  String? detailReturn;
  String? detailPayment;
  String? detail50;
  int? detailPackage;
  int? addressId;
  int? addressuser;
  String? addressCity;
  String? addressStreet;
  String? addressLocation;
  int? deliveryId;
  String? deliveryName;
  String? deliveryEmail;
  String? deliveryPassword;
  String? deliveryPhone1;
  String? deliveryPhone2;
  String? deliveryWhatsApp;
  int? deliveryVerifycode;
  int? deliveryApprove;
  int? deliveryAdmin;
  String? deliveryCreate;
  String? deliveryImage;
  int? deliveryCity;
  int? deliveryStreet;
  String? frontDrivingLicense;
  String? backDrivingLicense;
  String? deliveryDrivingLicenceNumber;
  String? checkCar;
  String? licensePlateNumber;
  String? carManual;
  String? technicalInspection;
  String? deliveryCheckCarPic;
  String? deliveryContact;
  int? profit;
  int? reasonId;
  String? reasonTheReason;
  String? reasonUser;
  int? reasonUserid;
  int? reasonOrderid;
  int? ownerId;
  String? ownerName;
  String? ownerEmail;
  String? ownerPassword;
  String? ownerProfile;
  int? ownerApprove;
  int? ownerAdmin;
  String? ownerPhone1;
  String? ownerPhone2;
  String? ownerWhatsApp;
  String? ownerStoreName;
  String? ownerNationalID;
  String? ownerPassportNumber;
  String? ownerIDCardNumber;
  String? ownerPassportPic;
  int? ownerCity;
  int? ownerStreet;
  double? ownerLat;
  double? ownerLng;
  int? ownerVerfiycode;
  int? packagingId;
  String? packagingPackaging;
  String? packagingPrice;
  int? adminId;
  String? adminName;
  String? adminImage;
  String? adminRole;
  int? cityAdminId;
  String? cityAdminName;
  String? cityAdminImage;
  String? cityAdminRole;
  int? delivery2Id;
  String? delivery2Name;
  String? delivery2Phone1;
  String? delivery2WhatsApp;
  String? delivery2Image;
  int? delivery3Id;
  String? delivery3Name;
  String? delivery3Phone1;
  String? delivery3WhatsApp;
  String? delivery3Image;

  // *** الحقول الجديدة: كائنات الصور الموقعة (base/tiny/full) ***
  ImageSigned? deliveryImageSigned;
  ImageSigned? delivery2ImageSigned;
  ImageSigned? delivery3ImageSigned;
  ImageSigned? adminImageSigned;
  ImageSigned? cityAdminImageSigned;
  ImageSigned? ownerProfileSigned;
  ImageSigned? ownerPassportPicSigned;

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
      this.orderAdmin,
      this.orderAdminCity,
      this.orderDelivery,
      this.orderDelivery2,
      this.orderDelivery3,
      this.ordersDatetime,
      this.orderNumber,
      this.orderReason,
      this.detailId,
      this.detailNumber,
      this.detailBox,
      this.detailCanOpened,
      this.detailReturn,
      this.detailPayment,
      this.detail50,
      this.detailPackage,
      this.addressId,
      this.addressuser,
      this.addressCity,
      this.addressStreet,
      this.addressLocation,
      this.deliveryId,
      this.deliveryName,
      this.deliveryEmail,
      this.deliveryPassword,
      this.deliveryPhone1,
      this.deliveryPhone2,
      this.deliveryWhatsApp,
      this.deliveryVerifycode,
      this.deliveryApprove,
      this.deliveryAdmin,
      this.deliveryCreate,
      this.deliveryImage,
      this.deliveryCity,
      this.deliveryStreet,
      this.frontDrivingLicense,
      this.backDrivingLicense,
      this.deliveryDrivingLicenceNumber,
      this.checkCar,
      this.licensePlateNumber,
      this.carManual,
      this.technicalInspection,
      this.deliveryCheckCarPic,
      this.deliveryContact,
      this.profit,
      this.reasonId,
      this.reasonTheReason,
      this.reasonUser,
      this.reasonUserid,
      this.reasonOrderid,
      this.ownerId,
      this.ownerName,
      this.ownerEmail,
      this.ownerPassword,
      this.ownerProfile,
      this.ownerApprove,
      this.ownerAdmin,
      this.ownerPhone1,
      this.ownerPhone2,
      this.ownerWhatsApp,
      this.ownerStoreName,
      this.ownerNationalID,
      this.ownerPassportNumber,
      this.ownerIDCardNumber,
      this.ownerPassportPic,
      this.ownerCity,
      this.ownerStreet,
      this.ownerLat,
      this.ownerLng,
      this.ownerVerfiycode,
      this.packagingId,
      this.packagingPackaging,
      this.packagingPrice,
      this.adminId,
      this.adminName,
      this.adminImage,
      this.adminRole,
      this.cityAdminId,
      this.cityAdminName,
      this.cityAdminImage,
      this.cityAdminRole,
      this.delivery2Id,
      this.delivery2Name,
      this.delivery2Phone1,
      this.delivery2WhatsApp,
      this.delivery2Image,
      this.delivery3Id,
      this.delivery3Name,
      this.delivery3Phone1,
      this.delivery3WhatsApp,
      this.delivery3Image,
      this.deliveryImageSigned,
      this.delivery2ImageSigned,
      this.delivery3ImageSigned,
      this.adminImageSigned,
      this.cityAdminImageSigned,
      this.ownerProfileSigned,
      this.ownerPassportPicSigned});

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
    orderAdmin = json['order_admin'];
    orderAdminCity = json['order_adminCity'];
    orderDelivery = json['order_delivery'];
    orderDelivery2 = json['order_delivery2'];
    orderDelivery3 = json['order_delivery3'];
    ordersDatetime = json['ordersDatetime'];
    orderNumber = json['order_number'];
    orderReason = json['order_reason'];
    detailId = json['detail_id'];
    detailNumber = json['detail_number'];
    detailBox = json['detail_box'];
    detailCanOpened = json['detail_canOpened'];
    detailReturn = json['detail_return'];
    detailPayment = json['detail_payment'];
    detail50 = json['detail_50'];
    detailPackage = json['detail_package'];
    addressId = json['addressId'];
    addressuser = json['addressuser'];
    addressCity = json['addressCity'];
    addressStreet = json['addressStreet'];
    addressLocation = json['addressLocation'];
    deliveryId = json['delivery_id'];
    deliveryName = json['delivery_name'];
    deliveryEmail = json['delivery_email'];
    deliveryPassword = json['delivery_password'];
    deliveryPhone1 = json['delivery_phone1'];
    deliveryPhone2 = json['delivery_phone2'];
    deliveryWhatsApp = json['delivery_whatsApp'];
    deliveryVerifycode = json['delivery_verifycode'];
    deliveryApprove = json['delivery_approve'];
    deliveryAdmin = json['delivery_admin'];
    deliveryCreate = json['delivery_create'];
    deliveryImage = json['delivery_image'];
    deliveryCity = json['delivery_city'];
    deliveryStreet = json['delivery_street'];
    frontDrivingLicense = json['front_driving_license'];
    backDrivingLicense = json['back_driving_license'];
    deliveryDrivingLicenceNumber = json['delivery_drivingLicenceNumber'];
    checkCar = json['check_car'];
    licensePlateNumber = json['license_plateNumber'];
    carManual = json['carManual'];
    technicalInspection = json['technical_Inspection'];
    deliveryCheckCarPic = json['delivery_checkCarPic'];
    deliveryContact = json['delivery_contact'];
    profit = json['profit'];
    reasonId = json['reason_id'];
    reasonTheReason = json['reason_theReason'];
    reasonUser = json['reason_user'];
    reasonUserid = json['reason_userid'];
    reasonOrderid = json['reason_orderid'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    ownerEmail = json['owner_email'];
    ownerPassword = json['owner_password'];
    ownerProfile = json['owner_profile'];
    ownerApprove = json['owner_approve'];
    ownerAdmin = json['owner_admin'];
    ownerPhone1 = json['owner_phone1'];
    ownerPhone2 = json['owner_phone2'];
    ownerWhatsApp = json['owner_whatsApp'];
    ownerStoreName = json['owner_storeName'];
    ownerNationalID = json['owner_NationalID'];
    ownerPassportNumber = json['owner_PassportNumber'];
    ownerIDCardNumber = json['owner_IDCardNumber'];
    ownerPassportPic = json['owner_passportPic'];
    ownerCity = json['owner_city'];
    ownerStreet = json['owner_street'];
    ownerLat = json['owner_lat'] is double
        ? json['owner_lat']
        : (json['owner_lat'] != null
            ? double.tryParse(json['owner_lat'].toString())
            : null);
    ownerLng = json['owner_lng'] is double
        ? json['owner_lng']
        : (json['owner_lng'] != null
            ? double.tryParse(json['owner_lng'].toString())
            : null);
    ownerVerfiycode = json['owner_verfiycode'];
    packagingId = json['packaging_id'];
    packagingPackaging = json['packaging_packaging'];
    packagingPrice = json['packaging_price'];
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    adminImage = json['admin_image'];
    adminRole = json['admin_role'];
    cityAdminId = json['city_admin_id'];
    cityAdminName = json['city_admin_name'];
    cityAdminImage = json['city_admin_image'];
    cityAdminRole = json['city_admin_role'];
    delivery2Id = json['delivery2_id'];
    delivery2Name = json['delivery2_name'];
    delivery2Phone1 = json['delivery2_phone1'];
    delivery2WhatsApp = json['delivery2_whatsApp'];
    delivery2Image = json['delivery2_image'];
    delivery3Id = json['delivery3_id'];
    delivery3Name = json['delivery3_name'];
    delivery3Phone1 = json['delivery3_phone1'];
    delivery3WhatsApp = json['delivery3_whatsApp'];
    delivery3Image = json['delivery3_image'];

    // --- الحقول الجديدة من JSON (إذا وُجدت) ---
    deliveryImageSigned = json['delivery_image_signed'] != null
        ? ImageSigned.fromJson(json['delivery_image_signed'])
        : null;
    delivery2ImageSigned = json['delivery2_image_signed'] != null
        ? ImageSigned.fromJson(json['delivery2_image_signed'])
        : null;
    delivery3ImageSigned = json['delivery3_image_signed'] != null
        ? ImageSigned.fromJson(json['delivery3_image_signed'])
        : null;
    adminImageSigned = json['admin_image_signed'] != null
        ? ImageSigned.fromJson(json['admin_image_signed'])
        : null;
    cityAdminImageSigned = json['city_admin_image_signed'] != null
        ? ImageSigned.fromJson(json['city_admin_image_signed'])
        : null;
    ownerProfileSigned = json['owner_profile_signed'] != null
        ? ImageSigned.fromJson(json['owner_profile_signed'])
        : null;
    ownerPassportPicSigned = json['owner_passportPic_signed'] != null
        ? ImageSigned.fromJson(json['owner_passportPic_signed'])
        : null;
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
    data['order_admin'] = orderAdmin;
    data['order_adminCity'] = orderAdminCity;
    data['order_delivery'] = orderDelivery;
    data['order_delivery2'] = orderDelivery2;
    data['order_delivery3'] = orderDelivery3;
    data['ordersDatetime'] = ordersDatetime;
    data['order_number'] = orderNumber;
    data['order_reason'] = orderReason;
    data['detail_id'] = detailId;
    data['detail_number'] = detailNumber;
    data['detail_box'] = detailBox;
    data['detail_canOpened'] = detailCanOpened;
    data['detail_return'] = detailReturn;
    data['detail_payment'] = detailPayment;
    data['detail_50'] = detail50;
    data['detail_package'] = detailPackage;
    data['addressId'] = addressId;
    data['addressuser'] = addressuser;
    data['addressCity'] = addressCity;
    data['addressStreet'] = addressStreet;
    data['addressLocation'] = addressLocation;
    data['delivery_id'] = deliveryId;
    data['delivery_name'] = deliveryName;
    data['delivery_email'] = deliveryEmail;
    data['delivery_password'] = deliveryPassword;
    data['delivery_phone1'] = deliveryPhone1;
    data['delivery_phone2'] = deliveryPhone2;
    data['delivery_whatsApp'] = deliveryWhatsApp;
    data['delivery_verifycode'] = deliveryVerifycode;
    data['delivery_approve'] = deliveryApprove;
    data['delivery_admin'] = deliveryAdmin;
    data['delivery_create'] = deliveryCreate;
    data['delivery_image'] = deliveryImage;
    data['delivery_city'] = deliveryCity;
    data['delivery_street'] = deliveryStreet;
    data['front_driving_license'] = frontDrivingLicense;
    data['back_driving_license'] = backDrivingLicense;
    data['delivery_drivingLicenceNumber'] = deliveryDrivingLicenceNumber;
    data['check_car'] = checkCar;
    data['license_plateNumber'] = licensePlateNumber;
    data['carManual'] = carManual;
    data['technical_Inspection'] = technicalInspection;
    data['delivery_checkCarPic'] = deliveryCheckCarPic;
    data['delivery_contact'] = deliveryContact;
    data['profit'] = profit;
    data['reason_id'] = reasonId;
    data['reason_theReason'] = reasonTheReason;
    data['reason_user'] = reasonUser;
    data['reason_userid'] = reasonUserid;
    data['reason_orderid'] = reasonOrderid;
    data['owner_id'] = ownerId;
    data['owner_name'] = ownerName;
    data['owner_email'] = ownerEmail;
    data['owner_password'] = ownerPassword;
    data['owner_profile'] = ownerProfile;
    data['owner_approve'] = ownerApprove;
    data['owner_admin'] = ownerAdmin;
    data['owner_phone1'] = ownerPhone1;
    data['owner_phone2'] = ownerPhone2;
    data['owner_whatsApp'] = ownerWhatsApp;
    data['owner_storeName'] = ownerStoreName;
    data['owner_NationalID'] = ownerNationalID;
    data['owner_PassportNumber'] = ownerPassportNumber;
    data['owner_IDCardNumber'] = ownerIDCardNumber;
    data['owner_passportPic'] = ownerPassportPic;
    data['owner_city'] = ownerCity;
    data['owner_street'] = ownerStreet;
    data['owner_lat'] = ownerLat;
    data['owner_lng'] = ownerLng;
    data['owner_verfiycode'] = ownerVerfiycode;
    data['packaging_id'] = packagingId;
    data['packaging_packaging'] = packagingPackaging;
    data['packaging_price'] = packagingPrice;
    data['admin_id'] = adminId;
    data['admin_name'] = adminName;
    data['admin_image'] = adminImage;
    data['admin_role'] = adminRole;
    data['city_admin_id'] = cityAdminId;
    data['city_admin_name'] = cityAdminName;
    data['city_admin_image'] = cityAdminImage;
    data['city_admin_role'] = cityAdminRole;
    data['delivery2_id'] = delivery2Id;
    data['delivery2_name'] = delivery2Name;
    data['delivery2_phone1'] = delivery2Phone1;
    data['delivery2_whatsApp'] = delivery2WhatsApp;
    data['delivery2_image'] = delivery2Image;
    data['delivery3_id'] = delivery3Id;
    data['delivery3_name'] = delivery3Name;
    data['delivery3_phone1'] = delivery3Phone1;
    data['delivery3_whatsApp'] = delivery3WhatsApp;
    data['delivery3_image'] = delivery3Image;

    // --- الحقول الجديدة في JSON ---
    data['delivery_image_signed'] =
        deliveryImageSigned != null ? deliveryImageSigned!.toJson() : null;
    data['delivery2_image_signed'] =
        delivery2ImageSigned != null ? delivery2ImageSigned!.toJson() : null;
    data['delivery3_image_signed'] =
        delivery3ImageSigned != null ? delivery3ImageSigned!.toJson() : null;
    data['admin_image_signed'] =
        adminImageSigned != null ? adminImageSigned!.toJson() : null;
    data['city_admin_image_signed'] =
        cityAdminImageSigned != null ? cityAdminImageSigned!.toJson() : null;
    data['owner_profile_signed'] =
        ownerProfileSigned != null ? ownerProfileSigned!.toJson() : null;
    data['owner_passportPic_signed'] = ownerPassportPicSigned != null
        ? ownerPassportPicSigned!.toJson()
        : null;

    return data;
  }
}

// نموذج لكائن الصور الموقعة
class ImageSigned {
  String? base;
  String? tiny;
  String? full;

  ImageSigned({this.base, this.tiny, this.full});

  ImageSigned.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    tiny = json['tiny'];
    full = json['full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base'] = base;
    data['tiny'] = tiny;
    data['full'] = full;
    return data;
  }
}
