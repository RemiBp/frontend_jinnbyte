class RestaurantUpdateProfileResponse {
  String? message;
  Producer? producer;
  BusinessProfile? businessProfile;

  RestaurantUpdateProfileResponse({this.message, this.producer, this.businessProfile});

  RestaurantUpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    producer = json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    businessProfile = json['businessProfile'] != null
        ? BusinessProfile.fromJson(json['businessProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (producer != null) {
      data['producer'] = producer!.toJson();
    }
    if (businessProfile != null) {
      data['businessProfile'] = businessProfile!.toJson();
    }
    return data;
  }
}

class Producer {
  int? id;
  int? userId;
  String? name;
  String? address;
  String? city;
  String? country;
  String? details;
  String? mapsUrl;
  String? placeId;
  double? latitude;
  double? longitude;
  LocationPoint? locationPoint;
  double? rating;
  String? phoneNumber;
  String? website;
  int? totalSeats;
  int? noOfTables;
  int? maxPartySize;
  String? type;
  String? status;
  bool? isActive;
  bool? isDeleted;
  String? document1;
  String? document2;
  String? document1Expiry;
  String? document2Expiry;
  String? createdAt;
  String? updatedAt;

  Producer({
    this.id,
    this.userId,
    this.name,
    this.address,
    this.city,
    this.country,
    this.details,
    this.mapsUrl,
    this.placeId,
    this.latitude,
    this.longitude,
    this.locationPoint,
    this.rating,
    this.phoneNumber,
    this.website,
    this.totalSeats,
    this.noOfTables,
    this.maxPartySize,
    this.type,
    this.status,
    this.isActive,
    this.isDeleted,
    this.document1,
    this.document2,
    this.document1Expiry,
    this.document2Expiry,
    this.createdAt,
    this.updatedAt,
  });

  Producer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    details = json['details'];
    mapsUrl = json['mapsUrl'];
    placeId = json['placeId'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    locationPoint = json['locationPoint'] != null
        ? LocationPoint.fromJson(json['locationPoint'])
        : null;
    rating = json['rating']?.toDouble();
    phoneNumber = json['phoneNumber'];
    website = json['website'];
    totalSeats = json['totalSeats'];
    noOfTables = json['noOfTables'];
    maxPartySize = json['maxPartySize'];
    type = json['type'];
    status = json['status'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    document1 = json['document1'];
    document2 = json['document2'];
    document1Expiry = json['document1Expiry'];
    document2Expiry = json['document2Expiry'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['details'] = details;
    data['mapsUrl'] = mapsUrl;
    data['placeId'] = placeId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (locationPoint != null) {
      data['locationPoint'] = locationPoint!.toJson();
    }
    data['rating'] = rating;
    data['phoneNumber'] = phoneNumber;
    data['website'] = website;
    data['totalSeats'] = totalSeats;
    data['noOfTables'] = noOfTables;
    data['maxPartySize'] = maxPartySize;
    data['type'] = type;
    data['status'] = status;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['document1'] = document1;
    data['document2'] = document2;
    data['document1Expiry'] = document1Expiry;
    data['document2Expiry'] = document2Expiry;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class LocationPoint {
  String? type;
  List<double>? coordinates;

  LocationPoint({this.type, this.coordinates});

  LocationPoint.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null
        ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      data['coordinates'] = coordinates;
    }
    return data;
  }
}

class BusinessProfile {
  int? id;
  String? businessName;
  String? address;
  String? phoneNumber;
  String? website;
  String? instagram;
  String? twitter;
  String? facebook;
  String? description;
  String? profileImageUrl;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;

  BusinessProfile({
    this.id,
    this.businessName,
    this.address,
    this.phoneNumber,
    this.website,
    this.instagram,
    this.twitter,
    this.facebook,
    this.description,
    this.profileImageUrl,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  BusinessProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    website = json['website'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    description = json['description'];
    profileImageUrl = json['profileImageUrl'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['businessName'] = businessName;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['website'] = website;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['facebook'] = facebook;
    data['description'] = description;
    data['profileImageUrl'] = profileImageUrl;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

