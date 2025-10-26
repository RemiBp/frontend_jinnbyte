class GetProducerProfileResponse {
  final Producer? producer;
  final BusinessProfile? businessProfile;

  GetProducerProfileResponse({
    this.producer,
    this.businessProfile,
  });

  factory GetProducerProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProducerProfileResponse(
      producer: json['producer'] != null ? Producer.fromJson(json['producer']) : null,
      businessProfile: json['businessProfile'] != null ? BusinessProfile.fromJson(json['businessProfile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'producer': producer?.toJson(),
      'businessProfile': businessProfile?.toJson(),
    };
  }
}

class Producer {
  final int? id;
  final int? userId;
  final String? name;
  final String? address;
  final String? city;
  final String? country;
  final String? details;
  final String? mapsUrl;
  final String? placeId;
  final String? latitude;
  final String? longitude;
  final LocationPoint? locationPoint;
  final double? rating;
  final String? phoneNumber;
  final String? website;
  final int? totalSeats;
  final int? noOfTables;
  final int? maxPartySize;
  final String? type;
  final String? status;
  final bool? isActive;
  final bool? isDeleted;
  final String? document1;
  final String? document2;
  final String? document1Expiry;
  final String? document2Expiry;
  final String? slotDuration;
  final String? createdAt;
  final String? updatedAt;

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
    this.slotDuration,
    this.createdAt,
    this.updatedAt,
  });

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      details: json['details'],
      mapsUrl: json['mapsUrl'],
      placeId: json['placeId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationPoint: json['locationPoint'] != null ? LocationPoint.fromJson(json['locationPoint']) : null,
      rating: json['rating']?.toDouble(),
      phoneNumber: json['phoneNumber'],
      website: json['website'],
      totalSeats: json['totalSeats'],
      noOfTables: json['noOfTables'],
      maxPartySize: json['maxPartySize'],
      type: json['type'],
      status: json['status'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      document1: json['document1'],
      document2: json['document2'],
      document1Expiry: json['document1Expiry'],
      document2Expiry: json['document2Expiry'],
      slotDuration: json['slotDuration'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'address': address,
      'city': city,
      'country': country,
      'details': details,
      'mapsUrl': mapsUrl,
      'placeId': placeId,
      'latitude': latitude,
      'longitude': longitude,
      'locationPoint': locationPoint?.toJson(),
      'rating': rating,
      'phoneNumber': phoneNumber,
      'website': website,
      'totalSeats': totalSeats,
      'noOfTables': noOfTables,
      'maxPartySize': maxPartySize,
      'type': type,
      'status': status,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'document1': document1,
      'document2': document2,
      'document1Expiry': document1Expiry,
      'document2Expiry': document2Expiry,
      'slotDuration': slotDuration,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class LocationPoint {
  final String? type;
  final List<double>? coordinates;

  LocationPoint({
    this.type,
    this.coordinates,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      type: json['type'],
      coordinates: json['coordinates'] != null ? List<double>.from(json['coordinates'].map((x) => x.toDouble())) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class BusinessProfile {
  final int? id;
  final String? website;
  final String? instagram;
  final String? twitter;
  final String? facebook;
  final String? description;
  final String? profileImageUrl;
  final String? createdAt;
  final String? updatedAt;

  BusinessProfile({
    this.id,
    this.website,
    this.instagram,
    this.twitter,
    this.facebook,
    this.description,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      id: json['id'],
      website: json['website'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      facebook: json['facebook'],
      description: json['description'],
      profileImageUrl: json['profileImageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'website': website,
      'instagram': instagram,
      'twitter': twitter,
      'facebook': facebook,
      'description': description,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}