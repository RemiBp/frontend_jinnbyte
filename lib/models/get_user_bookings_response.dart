class GetUserBookingsResponse {
  final UserBookingsData? data;

  GetUserBookingsResponse({
    this.data,
  });

  factory GetUserBookingsResponse.fromJson(Map<String, dynamic> json) {
    return GetUserBookingsResponse(
      data: json['data'] != null ? UserBookingsData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class UserBookingsData {
  final List<EventBookingEntry>? eventBookings;
  final List<RestaurantBookingEntry>? restaurantBookings;

  UserBookingsData({
    this.eventBookings,
    this.restaurantBookings,
  });

  factory UserBookingsData.fromJson(Map<String, dynamic> json) {
    return UserBookingsData(
      eventBookings: (json['eventBookings'] as List<dynamic>?)
          ?.map((item) => EventBookingEntry.fromJson(item as Map<String, dynamic>))
          .toList(),
      restaurantBookings: (json['restaurantBookings'] as List<dynamic>?)
          ?.map((item) => RestaurantBookingEntry.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventBookings': eventBookings?.map((item) => item.toJson()).toList(),
      'restaurantBookings': restaurantBookings?.map((item) => item.toJson()).toList(),
    };
  }
}

class EventBookingEntry {
  final EventBooking? booking;
  final Producer? producer;

  EventBookingEntry({
    this.booking,
    this.producer,
  });

  factory EventBookingEntry.fromJson(Map<String, dynamic> json) {
    return EventBookingEntry(
      booking: json['booking'] != null ? EventBooking.fromJson(json['booking'] as Map<String, dynamic>) : null,
      producer: json['producer'] != null ? Producer.fromJson(json['producer'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking': booking?.toJson(),
      'producer': producer?.toJson(),
    };
  }
}

class EventBooking {
  final int? id;
  final int? numberOfPersons;
  final String? totalPrice;
  final String? status;
  final String? internalNotes;
  final String? createdAt;
  final EventDetails? event;
  final bool? canCheckIn;
  final bool? canCancel;

  EventBooking({
    this.id,
    this.numberOfPersons,
    this.totalPrice,
    this.status,
    this.internalNotes,
    this.createdAt,
    this.event,
    this.canCheckIn,
    this.canCancel,
  });

  factory EventBooking.fromJson(Map<String, dynamic> json) {
    return EventBooking(
      id: json['id'] as int?,
      numberOfPersons: json['numberOfPersons'] as int?,
      totalPrice: json['totalPrice']?.toString(),
      status: json['status'] as String?,
      internalNotes: json['internalNotes'] as String?,
      createdAt: json['createdAt'] as String?,
      event: json['event'] != null ? EventDetails.fromJson(json['event'] as Map<String, dynamic>) : null,
      canCheckIn: json['canCheckIn'] as bool?,
      canCancel: json['canCancel'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberOfPersons': numberOfPersons,
      'totalPrice': totalPrice,
      'status': status,
      'internalNotes': internalNotes,
      'createdAt': createdAt,
      'event': event?.toJson(),
      'canCheckIn': canCheckIn,
      'canCancel': canCancel,
    };
  }
}

class EventDetails {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? timeZone;
  final String? venueName;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? serviceType;
  final String? pricePerGuest;
  final int? maxCapacity;
  final List<String>? eventImages;
  final String? status;
  final String? slug;
  final int? leisureId;
  final int? eventTypeId;
  final double? rating;
  final int? producerId;
  final bool? isActive;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final Producer? producer;

  EventDetails({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.timeZone,
    this.venueName,
    this.location,
    this.latitude,
    this.longitude,
    this.serviceType,
    this.pricePerGuest,
    this.maxCapacity,
    this.eventImages,
    this.status,
    this.slug,
    this.leisureId,
    this.eventTypeId,
    this.rating,
    this.producerId,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.producer,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      timeZone: json['timeZone'] as String?,
      venueName: json['venueName'] as String?,
      location: json['location'] as String?,
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      serviceType: json['serviceType'] as String?,
      pricePerGuest: json['pricePerGuest']?.toString(),
      maxCapacity: json['maxCapacity'] as int?,
      eventImages: (json['eventImages'] as List<dynamic>?)?.map((item) => item.toString()).toList(),
      status: json['status'] as String?,
      slug: json['slug'] as String?,
      leisureId: json['leisureId'] as int?,
      eventTypeId: json['eventTypeId'] as int?,
      rating: _toDouble(json['rating']),
      producerId: json['producerId'] as int?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      producer: json['producer'] != null ? Producer.fromJson(json['producer'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'timeZone': timeZone,
      'venueName': venueName,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'serviceType': serviceType,
      'pricePerGuest': pricePerGuest,
      'maxCapacity': maxCapacity,
      'eventImages': eventImages,
      'status': status,
      'slug': slug,
      'leisureId': leisureId,
      'eventTypeId': eventTypeId,
      'rating': rating,
      'producerId': producerId,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'producer': producer?.toJson(),
    };
  }
}

class RestaurantBookingEntry {
  final RestaurantBooking? booking;
  final Producer? producer;

  RestaurantBookingEntry({
    this.booking,
    this.producer,
  });

  factory RestaurantBookingEntry.fromJson(Map<String, dynamic> json) {
    return RestaurantBookingEntry(
      booking: json['booking'] != null ? RestaurantBooking.fromJson(json['booking'] as Map<String, dynamic>) : null,
      producer: json['producer'] != null ? Producer.fromJson(json['producer'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking': booking?.toJson(),
      'producer': producer?.toJson(),
    };
  }
}

class RestaurantBooking {
  final int? id;
  final String? startDateTime;
  final String? endDateTime;
  final String? checkInAt;
  final String? cancelAt;
  final String? slotStartTime;
  final String? slotEndTime;
  final String? bookingDate;
  final String? status;
  final String? location;
  final String? customerName;
  final bool? reviewAdded;
  final double? latitude;
  final double? longitude;
  final LocationPoint? locationPoint;
  final String? timeZone;
  final String? cancelBy;
  final String? cancelReason;
  final int? guestCount;
  final String? specialRequest;
  final String? day;
  final String? date;
  final bool? isActive;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final BookingUser? customer;
  final RestaurantAccount? restaurant;
  final bool? canCancel;
  final bool? canCheckIn;

  RestaurantBooking({
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.checkInAt,
    this.cancelAt,
    this.slotStartTime,
    this.slotEndTime,
    this.bookingDate,
    this.status,
    this.location,
    this.customerName,
    this.reviewAdded,
    this.latitude,
    this.longitude,
    this.locationPoint,
    this.timeZone,
    this.cancelBy,
    this.cancelReason,
    this.guestCount,
    this.specialRequest,
    this.day,
    this.date,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.restaurant,
    this.canCancel,
    this.canCheckIn,
  });

  factory RestaurantBooking.fromJson(Map<String, dynamic> json) {
    return RestaurantBooking(
      id: json['id'] as int?,
      startDateTime: json['startDateTime'] as String?,
      endDateTime: json['endDateTime'] as String?,
      checkInAt: json['checkInAt'] as String?,
      cancelAt: json['cancelAt'] as String?,
      slotStartTime: json['slotStartTime'] as String?,
      slotEndTime: json['slotEndTime'] as String?,
      bookingDate: json['bookingDate'] as String?,
      status: json['status'] as String?,
      location: json['location'] as String?,
      customerName: json['customerName'] as String?,
      reviewAdded: json['reviewAdded'] as bool?,
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      locationPoint: json['locationPoint'] != null ? LocationPoint.fromJson(json['locationPoint'] as Map<String, dynamic>) : null,
      timeZone: json['timeZone'] as String?,
      cancelBy: json['cancelBy']?.toString(),
      cancelReason: json['cancelReason'] as String?,
      guestCount: json['guestCount'] as int?,
      specialRequest: json['specialRequest'] as String?,
      day: json['day'] as String?,
      date: json['date'] as String?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      customer: json['customer'] != null ? BookingUser.fromJson(json['customer'] as Map<String, dynamic>) : null,
      restaurant: json['restaurant'] != null ? RestaurantAccount.fromJson(json['restaurant'] as Map<String, dynamic>) : null,
      canCancel: json['canCancel'] as bool?,
      canCheckIn: json['canCheckIn'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'checkInAt': checkInAt,
      'cancelAt': cancelAt,
      'slotStartTime': slotStartTime,
      'slotEndTime': slotEndTime,
      'bookingDate': bookingDate,
      'status': status,
      'location': location,
      'customerName': customerName,
      'reviewAdded': reviewAdded,
      'latitude': latitude,
      'longitude': longitude,
      'locationPoint': locationPoint?.toJson(),
      'timeZone': timeZone,
      'cancelBy': cancelBy,
      'cancelReason': cancelReason,
      'guestCount': guestCount,
      'specialRequest': specialRequest,
      'day': day,
      'date': date,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'customer': customer?.toJson(),
      'restaurant': restaurant?.toJson(),
      'canCancel': canCancel,
      'canCheckIn': canCheckIn,
    };
  }
}

class Producer {
  final int? id;
  final int? userId;
  final String? name;
  final String? companyEmail;
  final String? address;
  final String? city;
  final String? country;
  final String? details;
  final String? mapsUrl;
  final String? placeId;
  final double? latitude;
  final double? longitude;
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
  final BookingUser? user;

  Producer({
    this.id,
    this.userId,
    this.name,
    this.companyEmail,
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
    this.user,
  });

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      companyEmail: json['companyEmail'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      details: json['details'] as String?,
      mapsUrl: json['mapsUrl'] as String?,
      placeId: json['placeId']?.toString(),
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      locationPoint: json['locationPoint'] != null ? LocationPoint.fromJson(json['locationPoint'] as Map<String, dynamic>) : null,
      rating: _toDouble(json['rating']),
      phoneNumber: json['phoneNumber']?.toString(),
      website: json['website'] as String?,
      totalSeats: json['totalSeats'] as int?,
      noOfTables: json['noOfTables'] as int?,
      maxPartySize: json['maxPartySize'] as int?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      document1: json['document1'] as String?,
      document2: json['document2'] as String?,
      document1Expiry: json['document1Expiry']?.toString(),
      document2Expiry: json['document2Expiry']?.toString(),
      slotDuration: json['slotDuration']?.toString(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      user: json['user'] != null ? BookingUser.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'companyEmail': companyEmail,
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
      'user': user?.toJson(),
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
    final coords = json['coordinates'] as List<dynamic>?;
    return LocationPoint(
      type: json['type'] as String?,
      coordinates: coords
          ?.map((item) => _toDouble(item))
          .where((value) => value != null)
          .map((value) => value!)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class BookingUser {
  final int? id;
  final String? email;
  final String? deviceId;
  final String? fullName;
  final String? userName;
  final String? phoneNumber;
  final bool? isActive;
  final bool? isDeleted;
  final bool? isSocialLogin;
  final bool? isVerified;
  final int? followingCount;
  final int? followersCount;
  final double? latitude;
  final double? longitude;
  final String? bio;
  final String? profileImageUrl;
  final String? createdAt;
  final String? updatedAt;

  BookingUser({
    this.id,
    this.email,
    this.deviceId,
    this.fullName,
    this.userName,
    this.phoneNumber,
    this.isActive,
    this.isDeleted,
    this.isSocialLogin,
    this.isVerified,
    this.followingCount,
    this.followersCount,
    this.latitude,
    this.longitude,
    this.bio,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingUser.fromJson(Map<String, dynamic> json) {
    return BookingUser(
      id: json['id'] as int?,
      email: json['email'] as String?,
      deviceId: json['deviceId']?.toString(),
      fullName: json['fullName'] as String?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber']?.toString(),
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isSocialLogin: json['isSocialLogin'] as bool?,
      isVerified: json['isVerified'] as bool?,
      followingCount: json['followingCount'] as int?,
      followersCount: json['followersCount'] as int?,
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'deviceId': deviceId,
      'fullName': fullName,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'isSocialLogin': isSocialLogin,
      'isVerified': isVerified,
      'followingCount': followingCount,
      'followersCount': followersCount,
      'latitude': latitude,
      'longitude': longitude,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class RestaurantAccount extends BookingUser {
  final Producer? producer;

  RestaurantAccount({
    this.producer,
    int? id,
    String? email,
    String? deviceId,
    String? fullName,
    String? userName,
    String? phoneNumber,
    bool? isActive,
    bool? isDeleted,
    bool? isSocialLogin,
    bool? isVerified,
    int? followingCount,
    int? followersCount,
    double? latitude,
    double? longitude,
    String? bio,
    String? profileImageUrl,
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id,
          email: email,
          deviceId: deviceId,
          fullName: fullName,
          userName: userName,
          phoneNumber: phoneNumber,
          isActive: isActive,
          isDeleted: isDeleted,
          isSocialLogin: isSocialLogin,
          isVerified: isVerified,
          followingCount: followingCount,
          followersCount: followersCount,
          latitude: latitude,
          longitude: longitude,
          bio: bio,
          profileImageUrl: profileImageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory RestaurantAccount.fromJson(Map<String, dynamic> json) {
    return RestaurantAccount(
      producer: json['producer'] != null ? Producer.fromJson(json['producer'] as Map<String, dynamic>) : null,
      id: json['id'] as int?,
      email: json['email'] as String?,
      deviceId: json['deviceId']?.toString(),
      fullName: json['fullName'] as String?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber']?.toString(),
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isSocialLogin: json['isSocialLogin'] as bool?,
      isVerified: json['isVerified'] as bool?,
      followingCount: json['followingCount'] as int?,
      followersCount: json['followersCount'] as int?,
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['producer'] = producer?.toJson();
    return data;
  }
}

double? _toDouble(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is double) {
    return value;
  }
  if (value is int) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value);
  }
  return null;
}