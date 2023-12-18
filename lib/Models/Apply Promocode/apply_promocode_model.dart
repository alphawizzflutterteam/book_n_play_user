
class ApplypromoModel {
  bool status;
  String message;
  Data data;

  ApplypromoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApplypromoModel.fromJson(Map<String, dynamic> json) => ApplypromoModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String groundAmount;
  int discount;
  int payAmount;
  int couponId;
  String couponCode;
  DateTime expiryDate;

  Data({
    required this.groundAmount,
    required this.discount,
    required this.payAmount,
    required this.couponId,
    required this.couponCode,
    required this.expiryDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    groundAmount: json["ground_amount"],
    discount: json["discount"],
    payAmount: json["pay_amount"],
    couponId: json["coupon_id"],
    couponCode: json["coupon_code"],
    expiryDate: DateTime.parse(json["expiry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "ground_amount": groundAmount,
    "discount": discount,
    "pay_amount": payAmount,
    "coupon_id": couponId,
    "coupon_code": couponCode,
    "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
  };
}
