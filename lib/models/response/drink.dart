import 'dart:math';

class DrinkResponse {
  final String id;
  final String name;
  final String category; // Reference ID
  final Map<String, dynamic> details;
  final List<String> ingredients;

  DrinkResponse(
      {required this.id,
      required this.name,
      required this.category,
      required this.details,
      required this.ingredients});

  // Factory constructor to create an instance from a JSON map
  factory DrinkResponse.fromJson(Map<String, dynamic> json) {
    return DrinkResponse(
      id: json['_id'] ?? '', // MongoDB ID
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      details: Map<String, dynamic>.from(json['details'] ?? {}),
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }

  // Convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'details': details,
      'ingredients': ingredients,
    };
  }

  UiDrink toUIType() {
    return UiDrink(
        id: Random().nextInt(100),
        name: name,
        url: details['image'],
        description: details['description'],
        favorite: true,
        isLiked: false);
  }
}

class UiDrink {
  int id;
  String name;
  String url;
  String description;
  bool favorite;
  bool isLiked;

  UiDrink(
      {required this.id,
      required this.name,
      required this.url,
      required this.description,
      required this.favorite,
      required this.isLiked});
}
