import 'auth_ressponse.dart';

class CustomerAllPostsResponse {
  int? status;
  String? message;
  List<Data>? data;

  CustomerAllPostsResponse({this.status, this.message, this.data});

  CustomerAllPostsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? status;
  String? publishDate;
  String? description;
  String? coverImage;
  String? link;
  int? likesCount;
  int? shareCount;
  int? commentCount;
  int? overallAvgRating;
  int? userId;
  int? producerId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isDeleted;
  List<Images>? images;
  Producer? producer;
  User? user;

  Data(
      {this.id,
        this.type,
        this.status,
        this.publishDate,
        this.description,
        this.coverImage,
        this.link,
        this.likesCount,
        this.shareCount,
        this.commentCount,
        this.overallAvgRating,
        this.userId,
        this.producerId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isDeleted,
        this.images,
        this.producer,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    publishDate = json['publishDate'];
    description = json['description'];
    coverImage = json['coverImage'];
    link = json['link'];
    likesCount = json['likesCount'];
    shareCount = json['shareCount'];
    commentCount = json['commentCount'];
    overallAvgRating = json['overallAvgRating'];
    userId = json['userId'];
    producerId = json['producerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isDeleted = json['isDeleted'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    producer = json['producer'] != null
        ?  Producer.fromJson(json['producer'])
        : null;
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['status'] = status;
    data['publishDate'] = publishDate;
    data['description'] = description;
    data['coverImage'] = coverImage;
    data['link'] = link;
    data['likesCount'] = likesCount;
    data['shareCount'] = shareCount;
    data['commentCount'] = commentCount;
    data['overallAvgRating'] = overallAvgRating;
    data['userId'] = userId;
    data['producerId'] = producerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['isDeleted'] = isDeleted;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (producer != null) {
      data['producer'] = producer!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  int? postId;
  String? url;
  bool? isCoverImage;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isDeleted;

  Images(
      {this.id,
        this.postId,
        this.url,
        this.isCoverImage,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isDeleted});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    url = json['url'];
    isCoverImage = json['isCoverImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postId'] = postId;
    data['url'] = url;
    data['isCoverImage'] = isCoverImage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['isDeleted'] = isDeleted;
    return data;
  }
}

class Producer {
  int? id;
  int? userId;
  String? name;
  String? description;
  String? address;
  String? city;
  String? country;
  String? details;
  String? mapsUrl;
  String? placeId;
  String? latitude;
  String? longitude;
  var locationPoint;
  int? rating;
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

  Producer(
      {this.id,
        this.userId,
        this.name,
        this.description,
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
        this.updatedAt});

  Producer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    details = json['details'];
    mapsUrl = json['mapsUrl'];
    placeId = json['placeId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationPoint = json['locationPoint'];
    rating = json['rating'];
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
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['details'] = details;
    data['mapsUrl'] = mapsUrl;
    data['placeId'] = placeId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['locationPoint'] = locationPoint;
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

