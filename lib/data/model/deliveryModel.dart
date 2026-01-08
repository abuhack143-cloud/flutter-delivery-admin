class DeliveryModel {
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
  int? adminId;
  String? adminName;
  String? adminEmail;
  String? adminPassword;
  String? adminRole;

  // الحقول الجديدة على شكل كائن يحتوي على base/tiny/full
  ImageSigned? deliveryImageSigned;
  ImageSigned? frontDrivingLicenseSigned;
  ImageSigned? backDrivingLicenseSigned;
  ImageSigned? deliveryCheckCarPicSigned;
  ImageSigned? technicalInspectionSigned;
  ImageSigned? carManualSigned;

  DeliveryModel(
      {this.deliveryId,
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
      this.adminId,
      this.adminName,
      this.adminEmail,
      this.adminPassword,
      this.adminRole,
      this.deliveryImageSigned,
      this.frontDrivingLicenseSigned,
      this.backDrivingLicenseSigned,
      this.deliveryCheckCarPicSigned,
      this.technicalInspectionSigned,
      this.carManualSigned});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
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
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    adminPassword = json['admin_password'];
    adminRole = json['admin_role'];

    // الحقول الجديدة
    deliveryImageSigned = json['delivery_image_signed'] != null
        ? ImageSigned.fromJson(json['delivery_image_signed'])
        : null;
    frontDrivingLicenseSigned = json['front_driving_license_signed'] != null
        ? ImageSigned.fromJson(json['front_driving_license_signed'])
        : null;
    backDrivingLicenseSigned = json['back_driving_license_signed'] != null
        ? ImageSigned.fromJson(json['back_driving_license_signed'])
        : null;
    deliveryCheckCarPicSigned = json['delivery_checkCarPic_signed'] != null
        ? ImageSigned.fromJson(json['delivery_checkCarPic_signed'])
        : null;
    technicalInspectionSigned = json['technical_Inspection_signed'] != null
        ? ImageSigned.fromJson(json['technical_Inspection_signed'])
        : null;
    carManualSigned = json['carManual_signed'] != null
        ? ImageSigned.fromJson(json['carManual_signed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['admin_id'] = adminId;
    data['admin_name'] = adminName;
    data['admin_email'] = adminEmail;
    data['admin_password'] = adminPassword;
    data['admin_role'] = adminRole;

    // الحقول الجديدة
    data['delivery_image_signed'] =
        deliveryImageSigned != null ? deliveryImageSigned!.toJson() : null;
    data['front_driving_license_signed'] = frontDrivingLicenseSigned != null
        ? frontDrivingLicenseSigned!.toJson()
        : null;
    data['back_driving_license_signed'] = backDrivingLicenseSigned != null
        ? backDrivingLicenseSigned!.toJson()
        : null;
    data['delivery_checkCarPic_signed'] = deliveryCheckCarPicSigned != null
        ? deliveryCheckCarPicSigned!.toJson()
        : null;
    data['technical_Inspection_signed'] = technicalInspectionSigned != null
        ? technicalInspectionSigned!.toJson()
        : null;
    data['carManual_signed'] =
        carManualSigned != null ? carManualSigned!.toJson() : null;

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
