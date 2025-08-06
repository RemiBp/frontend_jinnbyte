class AuthResponse {
  User? user;
  String? accessToken;
  String? refreshToken;

  AuthResponse({this.user, this.accessToken, this.refreshToken});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class User {
  int? id;
  String? email;
  bool? isActive;
  Role? role;
  BusinessProfile? businessProfile;

  User({this.id, this.email, this.isActive, this.role, this.businessProfile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isActive = json['isActive'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    businessProfile = json['businessProfile'] != null
        ? new BusinessProfile.fromJson(json['businessProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['isActive'] = isActive;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (businessProfile != null) {
      data['businessProfile'] = businessProfile!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.name, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
  String? createdAt;
  String? updatedAt;

  BusinessProfile(
      {this.id,
        this.businessName,
        this.address,
        this.phoneNumber,
        this.website,
        this.instagram,
        this.twitter,
        this.facebook,
        this.description,
        this.profileImageUrl,
        this.createdAt,
        this.updatedAt});

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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
