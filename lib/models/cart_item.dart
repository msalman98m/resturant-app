import 'package:equatable/equatable.dart';
import 'food_item.dart';

class CartItem extends Equatable {
  final String id;
  final FoodItem foodItem;
  final int quantity;
  final List<String> specialInstructions;

  const CartItem({
    required this.id,
    required this.foodItem,
    required this.quantity,
    this.specialInstructions = const [],
  });

  double get totalPrice => foodItem.price * quantity;

  CartItem copyWith({
    String? id,
    FoodItem? foodItem,
    int? quantity,
    List<String>? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [id, foodItem, quantity, specialInstructions];
}
