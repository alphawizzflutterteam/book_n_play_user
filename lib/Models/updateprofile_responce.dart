class AuthApiResponse {
  bool? status;
  String? message;
  Userupdate? user;


  AuthApiResponse({this.message, this.user,});

  AuthApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];

    user = json['user'] != null ? Userupdate.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}

class Userupdate {
  int ?id;
  String ?firstName;
  String? lastName;
  String? mobile;
  String ?email;
  String ?emailVerifiedAt;
  String? mobileVerifiedAt;
  int ?isActive;
  String ?userImage;
  String ?code;
  String? profilePhotoId;
  String? gender;
  String? address;
  String? serviceP;
  String? services;
  String ?dateOfBirth;
  int ?role;
  String? vendorId;
  String? commissionPercent;
  String? flatDiscount;
  int ?wallet;
  DateTime ?createdAt;
  DateTime? updatedAt;

  Userupdate({
    this.id,
     this.firstName,
     this.lastName,
     this.mobile,
     this.email,
     this.emailVerifiedAt,
     this.mobileVerifiedAt,
     this.isActive,
     this.userImage,
     this.code,
     this.profilePhotoId,
     this.gender,
     this.address,
     this.serviceP,
     this.services,
     this.dateOfBirth,
     this.role,
     this.vendorId,
     this.commissionPercent,
     this.flatDiscount,
     this.wallet,
     this.createdAt,
     this.updatedAt,
  });

  factory Userupdate.fromJson(Map<String, dynamic> json) => Userupdate(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    mobileVerifiedAt: json["mobile_verified_at"],
    isActive: json["is_active"],
    userImage: json["user_image"],
    code: json["code"],
    profilePhotoId: json["profile_photo_id"],
    gender: json["gender"],
    address: json["address"],
    serviceP: json["service_p"],
    services: json["services"],
    dateOfBirth: json["date_of_birth"],
    role: json["role"],
    vendorId: json["vendor_id"],
    commissionPercent: json["commission_percent"],
    flatDiscount: json["flat_discount"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "mobile_verified_at": mobileVerifiedAt,
    "is_active": isActive,
    "user_image": userImage,
    "code": code,
    "profile_photo_id": profilePhotoId,
    "gender": gender,
    "address": address,
    "service_p": serviceP,
    "services": services,
    "date_of_birth": dateOfBirth,
    "role": role,
    "vendor_id": vendorId,
    "commission_percent": commissionPercent,
    "flat_discount": flatDiscount,
    "wallet": wallet,
  };
}
