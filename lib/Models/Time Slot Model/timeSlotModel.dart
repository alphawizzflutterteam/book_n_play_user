
class TimeslotModel {
  bool status;
  String message;
  TimeslotData data;

  TimeslotModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) => TimeslotModel(
    status: json["status"],
    message: json["message"],
    data: TimeslotData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class TimeslotData {
  String groundId;
  DateTime date;
  List<Slot> slots;

  TimeslotData({
    required this.groundId,
    required this.date,
    required this.slots,
  });

  factory TimeslotData.fromJson(Map<String, dynamic> json) => TimeslotData(
    groundId: json["ground_id"],
    date: DateTime.parse(json["date"]),
    slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ground_id": groundId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  String? fromTime;
  String? toTime;
  int? isBooked;
  int? isOffer;
  int? price;

  Slot({
     this.fromTime,
     this.toTime,
     this.isBooked,
     this.isOffer,
     this.price,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    fromTime: json["from_time"],
    toTime: json["to_time"],
    isBooked: json["is_booked"],
    isOffer: json["is_offer"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "from_time": fromTime,
    "to_time": toTime,
    "is_booked": isBooked,
    "is_offer": isOffer,
    "price": price,
  };
}
