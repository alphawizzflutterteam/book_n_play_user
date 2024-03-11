class BookingHistoryModel {
  bool status;
  String message;
  List<BookingHitoryData> data;

  BookingHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) => BookingHistoryModel(
    status: json["status"],
    message: json["message"],
    data: List<BookingHitoryData>.from(json["data"].map((x) => BookingHitoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BookingHitoryData {
  String id;
  String userId;
  String groundId;
  String vendorId;
  String isApprove;
  String? bookingDate;
  String bookingFrom;
  String bookingTo;
  String bookingName;
  String arrivalTime;
  String bookingHours;
  String groundRate;
  String addCommission;
  String subTotal;
  String couponId;
  String discount;
  String totalAmount;
  DateTime createdAt;
  String updatedAt;
  String graoundImage;
  String status;

  BookingHitoryData({
    required this.id,
    required this.userId,
    required this.groundId,
    required this.vendorId,
    required this.isApprove,
    required this.bookingDate,
    required this.bookingFrom,
    required this.bookingTo,
    required this.bookingName,
    required this.arrivalTime,
    required this.bookingHours,
    required this.groundRate,
    required this.addCommission,
    required this.subTotal,
    required this.couponId,
    required this.discount,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.graoundImage,
    required this.status,
  });

  factory BookingHitoryData.fromJson(Map<String, dynamic> json) => BookingHitoryData(
    id: json["id"].toString(),
    status: json["status"].toString(),
    userId: json["user_id"].toString(),
    groundId: json["ground_id"].toString(),
    vendorId: json["vendor_id"].toString(),
    isApprove: json["is_approve"].toString(),
    bookingDate: json["booking_date"].toString(),
    bookingFrom: json["booking_from"].toString(),
    bookingTo: json["booking_to"].toString(),
    bookingName: json["booking_name"].toString(),
    arrivalTime: json["arrival_time"].toString(),
    bookingHours: json["booking_hours"].toString(),
    groundRate: json["ground_rate"].toString(),
    addCommission: json["add_commission"].toString(),
    subTotal: json["sub_total"].toString(),
    couponId: json["coupon_id"].toString(),
    discount: json["discount"].toString(),
    totalAmount: json["total_amount"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"].toString(),
    graoundImage: json["groundimage"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ground_id": groundId,
    "vendor_id": vendorId,
    "is_approve": isApprove,
    "booking_date": bookingDate,
    "booking_from": bookingFrom,
    "booking_to": bookingTo,
    "booking_name": bookingName,
    "arrival_time": arrivalTime,
    "booking_hours": bookingHours,
    "ground_rate": groundRate,
    "add_commission": addCommission,
    "sub_total": subTotal,
    "coupon_id": couponId,
    "discount": discount,
    "total_amount": totalAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "groundimage": graoundImage,
  };
}
