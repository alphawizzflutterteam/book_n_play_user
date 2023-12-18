
class BookingDetailsModel {
  bool status;
  String message;
  Data data;

  BookingDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) => BookingDetailsModel(
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
  List<String> image;
  String groundTitle;
  String bookingName;
  String bookingDate;
  String bookingFrom;
  String bookingTo;
  String totalAmount;
  List<String> facility;
  String bookingCancelStatus;

  Data({
    required this.image,
    required this.groundTitle,
    required this.bookingName,
    required this.bookingDate,
    required this.bookingFrom,
    required this.bookingTo,
    required this.totalAmount,
    required this.facility,
    required this.bookingCancelStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    image: List<String>.from(json["image"].map((x) => x)),
    groundTitle: json["ground_title"].toString(),
    bookingName: json["booking_name"].toString(),
    bookingDate:json["booking_date"].toString(),
    bookingFrom: json["booking_from"].toString(),
    bookingTo: json["booking_to"].toString(),
    totalAmount: json["total_amount"].toString(),
    facility: List<String>.from(json["facility"].map((x) => x)),
    bookingCancelStatus: json["booking_cancel_status"].toString(),

  );

  Map<String, dynamic> toJson() => {
    "image": List<dynamic>.from(image.map((x) => x)),
    "ground_title": groundTitle,
    "booking_name": bookingName,
    "booking_date": bookingDate,
    "booking_from": bookingFrom,
    "booking_to": bookingTo,
    "total_amount": totalAmount,
    "facility": List<dynamic>.from(facility.map((x) => x)),
    "booking_cancel_status": bookingCancelStatus,

  };
}
