class ClaimProducerPlacesResponse {
  int? status;
  String? message;
  List<PlaceData>? data;

  ClaimProducerPlacesResponse({this.status, this.message, this.data});

  ClaimProducerPlacesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlaceData>[];
      json['data'].forEach((v) {
        data!.add(PlaceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PlaceData {
  int? id;
  int? userId;
  String? name;
  String? address;
  String? city;
  String? country;
  String? type;
  String? status;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? phoneNumber;
  String? website;
  String? document1;
  String? document2;

  PlaceData({
    this.id,
    this.userId,
    this.name,
    this.address,
    this.city,
    this.country,
    this.type,
    this.status,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.website,
    this.document1,
    this.document2,
  });

  PlaceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    type = json['type'];
    status = json['status'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phoneNumber'];
    website = json['website'];
    document1 = json['document1'];
    document2 = json['document2'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['name'] = name;
    map['address'] = address;
    map['city'] = city;
    map['country'] = country;
    map['type'] = type;
    map['status'] = status;
    map['isActive'] = isActive;
    map['isDeleted'] = isDeleted;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['phoneNumber'] = phoneNumber;
    map['website'] = website;
    map['document1'] = document1;
    map['document2'] = document2;
    return map;
  }
}
