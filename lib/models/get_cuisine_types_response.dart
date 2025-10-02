class GetCuisineTypesResponse {
  List<CuisineType>? cuisineTypes;
  int? count;
  int? currentPage;
  int? totalPage;

  GetCuisineTypesResponse({
    this.cuisineTypes,
    this.count,
    this.currentPage,
    this.totalPage,
  });

  GetCuisineTypesResponse.fromJson(Map<String, dynamic> json) {
    if (json['cuisineTypes'] != null) {
      cuisineTypes = <CuisineType>[];
      json['cuisineTypes'].forEach((v) {
        cuisineTypes!.add(CuisineType.fromJson(v));
      });
    }
    count = json['count'];
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cuisineTypes != null) {
      data['cuisineTypes'] = cuisineTypes!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['currentPage'] = currentPage;
    data['totalPage'] = totalPage;
    return data;
  }
}

class CuisineType {
  int? id;
  String? name;
  String? imageUrl;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  CuisineType({
    this.id,
    this.name,
    this.imageUrl,
    this.isDeleted,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  CuisineType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['isDeleted'] = isDeleted;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}