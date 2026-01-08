class StorageOrderModel {
  int? storageId;
  int? storageOwner;
  int? storageStatus;
  int? storageAdmin;
  int? storageDelivery;
  int? storageCate1;
  int? storageCate2;
  int? storageCate3;
  int? storageNumber;
  String? storageOrderSize;
  String? storageBoxSize;
  String? storageNewOld;
  String? storageFragile;
  String? storageBroken;
  String? storageTemperature;
  String? storageLighSun;
  String? storageLocation;
  String? storageDuration;
  String? storageConditions;
  String? storageCost;
  String? storageOrderNumber;
  String? storageDate;
  int? cate1Id;
  String? cate1Name;
  int? cate2Id;
  String? cate2Name;
  int? categories1;
  int? cate3Id;
  String? cate3Name;
  int? categories2;
  int? boxId;
  String? boxSize;
  int? boxWidth;
  int? boxHeight;
  int? boxLength;
  int? boxWeight;
  int? boxPrice;
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
  int? adminId;
  String? adminName;
  String? adminEmail;
  String? adminImage;
  String? adminPassword;
  String? adminRole;
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
  String? frontDrivingLicense;
  String? backDrivingLicense;
  String? deliveryDrivingLicenceNumber;
  String? checkCar;
  String? licensePlateNumber;
  String? carManual;
  String? technicalInspection;
  String? deliveryCheckCarPic;
  String? deliveryContact;

  StorageOrderModel(
      {this.storageId,
      this.storageOwner,
      this.storageStatus,
      this.storageAdmin,
      this.storageDelivery,
      this.storageCate1,
      this.storageCate2,
      this.storageCate3,
      this.storageNumber,
      this.storageOrderSize,
      this.storageBoxSize,
      this.storageNewOld,
      this.storageFragile,
      this.storageBroken,
      this.storageTemperature,
      this.storageLighSun,
      this.storageLocation,
      this.storageDuration,
      this.storageConditions,
      this.storageCost,
      this.storageOrderNumber,
      this.storageDate,
      this.cate1Id,
      this.cate1Name,
      this.cate2Id,
      this.cate2Name,
      this.categories1,
      this.cate3Id,
      this.cate3Name,
      this.categories2,
      this.boxId,
      this.boxSize,
      this.boxWidth,
      this.boxHeight,
      this.boxLength,
      this.boxWeight,
      this.boxPrice,
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
      this.adminId,
      this.adminName,
      this.adminEmail,
      this.adminImage,
      this.adminPassword,
      this.adminRole,
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
      this.frontDrivingLicense,
      this.backDrivingLicense,
      this.deliveryDrivingLicenceNumber,
      this.checkCar,
      this.licensePlateNumber,
      this.carManual,
      this.technicalInspection,
      this.deliveryCheckCarPic,
      this.deliveryContact});

  StorageOrderModel.fromJson(Map<String, dynamic> json) {
    storageId = json['storage_id'];
    storageOwner = json['storage_owner'];
    storageStatus = json['storage_status'];
    storageAdmin = json['storage_admin'];
    storageDelivery = json['storage_delivery'];
    storageCate1 = json['storage_cate1'];
    storageCate2 = json['storage_cate2'];
    storageCate3 = json['storage_cate3'];
    storageNumber = json['storage_number'];
    storageOrderSize = json['storage_orderSize'];
    storageBoxSize = json['storage_boxSize'];
    storageNewOld = json['storage_newOld'];
    storageFragile = json['storage_Fragile'];
    storageBroken = json['storage_broken'];
    storageTemperature = json['storage_temperature'];
    storageLighSun = json['storage_lighSun'];
    storageLocation = json['storage_location'];
    storageDuration = json['storage_duration'];
    storageConditions = json['storage_conditions'];
    storageCost = json['storage_cost'];
    storageOrderNumber = json['storage_orderNumber'];
    storageDate = json['storage_date'];
    cate1Id = json['cate1_id'];
    cate1Name = json['cate1_name'];
    cate2Id = json['cate2_id'];
    cate2Name = json['cate2_name'];
    categories1 = json['categories1'];
    cate3Id = json['cate3_id'];
    cate3Name = json['cate3_name'];
    categories2 = json['categories2'];
    boxId = json['box_id'];
    boxSize = json['box_size'];
    boxWidth = json['box_width'];
    boxHeight = json['box_height'];
    boxLength = json['box_length'];
    boxWeight = json['box_weight'];
    boxPrice = json['box_price'];
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
    ownerLat = json['owner_lat'];
    ownerLng = json['owner_lng'];
    ownerVerfiycode = json['owner_verfiycode'];
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    adminImage = json['admin_image'];
    adminPassword = json['admin_password'];
    adminRole = json['admin_role'];
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
    frontDrivingLicense = json['front_driving_license'];
    backDrivingLicense = json['back_driving_license'];
    deliveryDrivingLicenceNumber = json['delivery_drivingLicenceNumber'];
    checkCar = json['check_car'];
    licensePlateNumber = json['license_plateNumber'];
    carManual = json['carManual'];
    technicalInspection = json['technical_Inspection'];
    deliveryCheckCarPic = json['delivery_checkCarPic'];
    deliveryContact = json['delivery_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storage_id'] = storageId;
    data['storage_owner'] = storageOwner;
    data['storage_status'] = storageStatus;
    data['storage_admin'] = storageAdmin;
    data['storage_delivery'] = storageDelivery;
    data['storage_cate1'] = storageCate1;
    data['storage_cate2'] = storageCate2;
    data['storage_cate3'] = storageCate3;
    data['storage_number'] = storageNumber;
    data['storage_orderSize'] = storageOrderSize;
    data['storage_boxSize'] = storageBoxSize;
    data['storage_newOld'] = storageNewOld;
    data['storage_Fragile'] = storageFragile;
    data['storage_broken'] = storageBroken;
    data['storage_temperature'] = storageTemperature;
    data['storage_lighSun'] = storageLighSun;
    data['storage_location'] = storageLocation;
    data['storage_duration'] = storageDuration;
    data['storage_conditions'] = storageConditions;
    data['storage_cost'] = storageCost;
    data['storage_orderNumber'] = storageOrderNumber;
    data['storage_date'] = storageDate;
    data['cate1_id'] = cate1Id;
    data['cate1_name'] = cate1Name;
    data['cate2_id'] = cate2Id;
    data['cate2_name'] = cate2Name;
    data['categories1'] = categories1;
    data['cate3_id'] = cate3Id;
    data['cate3_name'] = cate3Name;
    data['categories2'] = categories2;
    data['box_id'] = boxId;
    data['box_size'] = boxSize;
    data['box_width'] = boxWidth;
    data['box_height'] = boxHeight;
    data['box_length'] = boxLength;
    data['box_weight'] = boxWeight;
    data['box_price'] = boxPrice;
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
    data['admin_id'] = adminId;
    data['admin_name'] = adminName;
    data['admin_email'] = adminEmail;
    data['admin_image'] = adminImage;
    data['admin_password'] = adminPassword;
    data['admin_role'] = adminRole;
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
    data['front_driving_license'] = frontDrivingLicense;
    data['back_driving_license'] = backDrivingLicense;
    data['delivery_drivingLicenceNumber'] = deliveryDrivingLicenceNumber;
    data['check_car'] = checkCar;
    data['license_plateNumber'] = licensePlateNumber;
    data['carManual'] = carManual;
    data['technical_Inspection'] = technicalInspection;
    data['delivery_checkCarPic'] = deliveryCheckCarPic;
    data['delivery_contact'] = deliveryContact;
    return data;
  }
}