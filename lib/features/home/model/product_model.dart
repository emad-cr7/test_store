import 'category_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final CategoryModel category;
  bool isFavorite;
  bool shoppingCart;


  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    this.isFavorite = false,
    this.shoppingCart = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'description': this.description,
      'images': this.images,
      'category': this.category.toJson(),
      'isFavorite': this.isFavorite,
      'shoppingCart': this.shoppingCart,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description']?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: CategoryModel.fromJson(json['category'] ?? {}),
      isFavorite: json['isFavorite'] ?? false,
      shoppingCart: json['shoppingCart'] ?? false,
    );
  }
}
