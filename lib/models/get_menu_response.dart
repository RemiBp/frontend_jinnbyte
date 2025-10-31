class GetMenuResponse {
  final List<MenuCategory>? menu;

  GetMenuResponse({this.menu});

  factory GetMenuResponse.fromJson(Map<String, dynamic> json) {
    return GetMenuResponse(
      menu: json["menu"] == null
          ? []
          : List<MenuCategory>.from(
        json["menu"].map((x) => MenuCategory.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "menu": menu == null
        ? []
        : List<dynamic>.from(menu!.map((x) => x.toJson())),
  };
}

class MenuCategory {
  final int? id;
  final String? name;
  final List<Dish>? dishes;

  MenuCategory({this.id, this.name, this.dishes});

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json["id"],
      name: json["name"],
      dishes: json["dishes"] == null
          ? []
          : List<Dish>.from(
        json["dishes"].map((x) => Dish.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dishes": dishes == null
        ? []
        : List<dynamic>.from(dishes!.map((x) => x.toJson())),
  };
}

class Dish {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final double? rating;

  Dish({
    this.id,
    this.name,
    this.description,
    this.price,
    this.rating,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: (json["price"] != null)
          ? (json["price"] as num).toDouble()
          : null,
      rating: (json["rating"] != null)
          ? (json["rating"] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "rating": rating,
  };
}
