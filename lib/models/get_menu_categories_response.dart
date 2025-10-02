class GetMenuCategoriesResponse {
  final List<MenuCategory>? menuCategories;
  final int? count;
  final int? currentPage;
  final int? totalPage;

  GetMenuCategoriesResponse({
    this.menuCategories,
    this.count,
    this.currentPage,
    this.totalPage,
  });

  factory GetMenuCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return GetMenuCategoriesResponse(
      menuCategories: json['menuCategories'] != null
          ? (json['menuCategories'] as List)
              .map((item) => MenuCategory.fromJson(item))
              .toList()
          : null,
      count: json['count'],
      currentPage: json['currentPage'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuCategories': menuCategories?.map((item) => item.toJson()).toList(),
      'count': count,
      'currentPage': currentPage,
      'totalPage': totalPage,
    };
  }
}

class MenuCategory {
  final int? id;
  final String? name;

  MenuCategory({
    this.id,
    this.name,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}