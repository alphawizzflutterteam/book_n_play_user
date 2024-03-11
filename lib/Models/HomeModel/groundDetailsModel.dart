
class GroundDetailsModel {
  bool status;
  String message;
  GroundDetailData data;

  GroundDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GroundDetailsModel.fromJson(Map<String, dynamic> json) => GroundDetailsModel(
    status: json["status"],
    message: json["message"],
    data: GroundDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class GroundDetailData {
  List<String> image;
  Details details;
  List<TimeSlote> timeSlotes;

  GroundDetailData({
    required this.image,
    required this.details,
    required this.timeSlotes,
  });

  factory GroundDetailData.fromJson(Map<String, dynamic> json) => GroundDetailData(
    image: List<String>.from(json["image"].map((x) => x)),
    details: Details.fromJson(json["details"]),
    timeSlotes: List<TimeSlote>.from(json["time_slotes"].map((x) => TimeSlote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "image": List<dynamic>.from(image.map((x) => x)),
    "details": details.toJson(),
    "time_slotes": List<dynamic>.from(timeSlotes.map((x) => x.toJson())),
  };
}

class Details {
  int id;
  int vendorId;
  String title;
  int categoryId;
  String openingTime;
  String closingTime;
  String description;
  List<String> facility;
  String address;
  int defaultPrice;
  int isActive;
  String commissionType;
  String addressLink;
  dynamic percent;
  int flat;
  dynamic holiday;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int totalAmount;

  Details({
    required this.id,
    required this.addressLink,
    required this.vendorId,
    required this.title,
    required this.categoryId,
    required this.openingTime,
    required this.closingTime,
    required this.description,
    required this.facility,
    required this.address,
    required this.defaultPrice,
    required this.isActive,
    required this.commissionType,
    required this.percent,
    required this.flat,
    required this.holiday,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAmount,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"]??0,
    vendorId: json["vendor_id"]??0,
    title: json["title"]??'',
    categoryId: json["category_id"]??0,
    openingTime: json["opening_time"]??'',
    closingTime: json["closing_time"]??'',
    description: json["description"]??'',
    facility: json["facility"]==[]||json["facility"]==null?[]:List<String>.from(json["facility"].map((x) => x)),
    address: json["address"]??'',
    defaultPrice: json["default_price"]??0,
    isActive: json["is_active"]??0,
    commissionType: json["commission_type"]??'',
    percent: json["percent"]??'',
    flat: json["flat"]??0,
    holiday: json["holiday"]??'',
    image: json["image"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalAmount: json["total_amount"]??0,
    addressLink: json["address_link"] ?? 'Not Available',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "title": title,
    "category_id": categoryId,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "description": description,
    "facility": List<dynamic>.from(facility.map((x) => x)),
    "address": address,
    "default_price": defaultPrice,
    "is_active": isActive,
    "commission_type": commissionType,
    "percent": percent,
    "flat": flat,
    "holiday": holiday,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_amount": totalAmount,
  };
}

class TimeSlote {
  String? fromTime;
  String? toTime;
  int? isBooked;
  int? isOffer;
  int? price;

  TimeSlote({
    this.fromTime,
    this.toTime,
    this.isBooked,
    this.isOffer,
    this.price,
  });

  factory TimeSlote.fromJson(Map<String, dynamic> json) => TimeSlote(
    fromTime: json["from_time"] ??'',
    toTime: json["to_time"] ??'',
    isBooked: json["is_booked"]??'',
    isOffer: json["is_offer"]??'',
    price: json["price"]??'',
  );

  Map<String, dynamic> toJson() => {
    "from_time": fromTime,
    "to_time": toTime,
    "is_booked": isBooked,
    "is_offer": isOffer,
    "price": price,
  };
}
