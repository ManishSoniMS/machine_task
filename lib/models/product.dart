import 'package:equatable/equatable.dart';

class GetProducts extends Equatable {
  const GetProducts({
    required this.total,
    required this.skip,
    required this.limit,
    required this.products,
  });

  factory GetProducts.fromMap(Map<String, dynamic> map) {
    return GetProducts(
      total: map['total'],
      skip: map['skip'],
      limit: map['limit'],
      products: (map['products'] as List<dynamic>)
          .map((e) => Product.fromMap(e))
          .toList(),
    );
  }

  final int total;
  final int skip;
  final int limit;
  final List<Product> products;

  GetProducts copyWith({
    int? total,
    int? skip,
    int? limit,
    List<Product>? products,
  }) {
    return GetProducts(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      products: products ?? this.products,
    );
  }

  @override
  String toString() => 'GetProducts{ total: $total, skip: $skip, '
      'limit: $limit, products: $products,}';

  @override
  List<Object?> get props => [total, skip, limit, products];
}

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: int.parse(map['price'].toString()),
      discountPercentage: map['discountPercentage'],
      rating: double.parse(map['rating'].toString()),
      stock: map['stock'],
      brand: map['brand'],
      category: map['category'],
      thumbnail: map['thumbnail'],
      images: List<String>.from(map['images']),
    );
  }

  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  @override
  String toString() =>
      'Products{ id: $id, title: $title, description: $description, '
      'price: $price, discountPercentage: $discountPercentage, '
      'rating: $rating, stock: $stock, brand: $brand, category: $category, '
      'thumbnail: $thumbnail, images: $images,}';

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnail,
        images,
      ];
}
