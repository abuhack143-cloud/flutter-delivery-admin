class ReportModel {
  int? reportId;
  String? reportTheReport;
  int? reportUserid;
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

  ImageSigned? ownerProfileSigned;

  ReportModel(
      {this.reportId,
      this.reportTheReport,
      this.reportUserid,
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
      this.ownerProfileSigned,
      this.ownerVerfiycode});

  ReportModel.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
    reportTheReport = json['report_theReport'];
    reportUserid = json['report_userid'];
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

    ownerProfileSigned = json['owner_profile_signed'] != null
        ? ImageSigned.fromJson(json['owner_profile_signed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_id'] = reportId;
    data['report_theReport'] = reportTheReport;
    data['report_userid'] = reportUserid;
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

    data['owner_profile_signed'] =
        ownerProfileSigned != null ? ownerProfileSigned!.toJson() : null;

    return data;
  }
}

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
