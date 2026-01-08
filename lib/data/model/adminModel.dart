class AdminModel {
  int? adminId;
  String? adminName;
  String? adminEmail;
  String? adminBranch;
  String? adminImage;
  String? adminPassword;
  String? adminRole;

  // الحقل الجديد على شكل كائن يحتوي على base/tiny/full
  ImageSigned? adminImageSigned;

  AdminModel({
    this.adminId,
    this.adminName,
    this.adminEmail,
    this.adminBranch,
    this.adminImage,
    this.adminPassword,
    this.adminRole,
    this.adminImageSigned,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    adminBranch = json['admin_branch'];
    adminImage = json['admin_image'];
    adminPassword = json['admin_password'];
    adminRole = json['admin_role'];

    adminImageSigned = json['admin_image_signed'] != null
        ? ImageSigned.fromJson(json['admin_image_signed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin_id'] = adminId;
    data['admin_name'] = adminName;
    data['admin_email'] = adminEmail;
    data['admin_branch'] = adminBranch;
    data['admin_image'] = adminImage;
    data['admin_password'] = adminPassword;
    data['admin_role'] = adminRole;

    data['admin_image_signed'] =
        adminImageSigned != null ? adminImageSigned!.toJson() : null;

    return data;
  }
}

// نموذج لكائن الصور الموقعة (نفسه مثل الذي استخدمته في DeliveryModel)
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
