class CustomerProfileResponse {
  User? user;

  CustomerProfileResponse({this.user});

  CustomerProfileResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? deviceId;
  String? fullName;
  String? userName;
  String? phoneNumber;
  bool? isActive;
  bool? isDeleted;
  bool? isSocialLogin;
  bool? isVerified;
  int? followingCount;
  int? followersCount;
  double? latitude;
  double? longitude;
  String? bio;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
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
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    deviceId = json['deviceId'];
    fullName = json['fullName'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    isSocialLogin = json['isSocialLogin'];
    isVerified = json['isVerified'];
    followingCount = json['followingCount'];
    followersCount = json['followersCount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['deviceId'] = deviceId;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['isSocialLogin'] = isSocialLogin;
    data['isVerified'] = isVerified;
    data['followingCount'] = followingCount;
    data['followersCount'] = followersCount;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
