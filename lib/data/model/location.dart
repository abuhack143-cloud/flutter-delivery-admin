class LocationModel {
  int? loactionId;
  int? locationUserid;
  String? locationLat;
  String? locationLng;
  int? locationOrderid;
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

  LocationModel(
      {this.loactionId,
      this.locationUserid,
      this.locationLat,
      this.locationLng,
      this.locationOrderid,
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
      this.profit});

  LocationModel.fromJson(Map<String, dynamic> json) {
    loactionId = json['loaction_id'];
    locationUserid = json['location_userid'];
    locationLat = json['location_lat'];
    locationLng = json['location_lng'];
    locationOrderid = json['location_orderid'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaction_id'] = loactionId;
    data['location_userid'] = locationUserid;
    data['location_lat'] = locationLat;
    data['location_lng'] = locationLng;
    data['location_orderid'] = locationOrderid;
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
    return data;
  }
}