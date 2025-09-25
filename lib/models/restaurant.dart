import 'package:equatable/equatable.dart';
import 'food_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String address;
  final double rating;
  final int reviewCount;
  final int deliveryTime; // in minutes
  final double deliveryFee;
  final double minimumOrder;
  final List<String> categories;
  final List<FoodItem> menu;
  final bool isOpen;
  final String phoneNumber;
  final String cuisineType;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.address,
    this.rating = 4.0,
    this.reviewCount = 0,
    this.deliveryTime = 30,
    this.deliveryFee = 2.99,
    this.minimumOrder = 15.0,
    this.categories = const [],
    this.menu = const [],
    this.isOpen = true,
    required this.phoneNumber,
    required this.cuisineType,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? address,
    double? rating,
    int? reviewCount,
    int? deliveryTime,
    double? deliveryFee,
    double? minimumOrder,
    List<String>? categories,
    List<FoodItem>? menu,
    bool? isOpen,
    String? phoneNumber,
    String? cuisineType,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      categories: categories ?? this.categories,
      menu: menu ?? this.menu,
      isOpen: isOpen ?? this.isOpen,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cuisineType: cuisineType ?? this.cuisineType,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    address,
    rating,
    reviewCount,
    deliveryTime,
    deliveryFee,
    minimumOrder,
    categories,
    menu,
    isOpen,
    phoneNumber,
    cuisineType,
  ];
}
