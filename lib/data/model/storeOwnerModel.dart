class StoreOwnerModel {
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
  String? adminPassword;
  String? adminRole;
  int? cityId;
  String? cityPlate;
  String? cityName;
  int? cityClassification;
  String? cityPrice;

  // الحقول الجديدة على شكل كائن يحتوي على base/tiny/full
  ImageSigned? ownerProfileSigned;
  ImageSigned? ownerPassportPicSigned;

  StoreOwnerModel(
      {this.ownerId,
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
      this.adminPassword,
      this.adminRole,
      this.cityId,
      this.cityPlate,
      this.cityName,
      this.cityClassification,
      this.cityPrice,
      this.ownerProfileSigned,
      this.ownerPassportPicSigned});

  StoreOwnerModel.fromJson(Map<String, dynamic> json) {
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
    ownerLat = double.tryParse(json['owner_lat']?.toString() ?? "");
    ownerLng = double.tryParse(json['owner_lng']?.toString() ?? "");
    ownerVerfiycode = json['owner_verfiycode'];
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    adminPassword = json['admin_password'];
    adminRole = json['admin_role'];
    cityId = json['City_id'];
    cityPlate = json['City_Plate'];
    cityName = json['City_name'];
    cityClassification = json['City_Classification'];
    cityPrice = json['City_price'];

    // الحقول الجديدة (توافق مفاتيح JSON من الـ API)
    ownerProfileSigned = json['owner_profile_signed'] != null
        ? ImageSigned.fromJson(json['owner_profile_signed'])
        : null;
    ownerPassportPicSigned = json['owner_passportPic_signed'] != null
        ? ImageSigned.fromJson(json['owner_passportPic_signed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['admin_password'] = adminPassword;
    data['admin_role'] = adminRole;
    data['City_id'] = cityId;
    data['City_Plate'] = cityPlate;
    data['City_name'] = cityName;
    data['City_Classification'] = cityClassification;
    data['City_price'] = cityPrice;

    // الحقول الجديدة
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
