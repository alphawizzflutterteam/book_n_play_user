class FAQResponse {
  bool? status;
  String? message;
  List<FAQData>? data;

  FAQResponse({this.status, this.message, this.data});

  FAQResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FAQData>[];
      json['data'].forEach((v) {
        data!.add( FAQData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAQData {
  int? id;
  String? title;
  String? description;
 // Null? createdAt;
 // Null? updatedAt;

  FAQData({this.id, this.title, this.description, /*this.createdAt, this.updatedAt*/});

  FAQData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  //  createdAt = json['created_at'];
  //  updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
   // data['created_at'] = this.createdAt;
    //data['updated_at'] = this.updatedAt;
    return data;
  }
}
