import 'package:equatable/equatable.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';

abstract class FoodOrderingEvent extends Equatable {
  const FoodOrderingEvent();

  @override
  List<Object?> get props => [];
}

// Restaurant Events
class LoadRestaurants extends FoodOrderingEvent {
  const LoadRestaurants();
}

class SelectRestaurant extends FoodOrderingEvent {
  final Restaurant restaurant;

  const SelectRestaurant(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class FilterRestaurantsByCategory extends FoodOrderingEvent {
  final String category;

  const FilterRestaurantsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchRestaurants extends FoodOrderingEvent {
  final String query;

  const SearchRestaurants(this.query);

  @override
  List<Object?> get props => [query];
}

// Menu Events
class LoadMenu extends FoodOrderingEvent {
  final String restaurantId;

  const LoadMenu(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}

class FilterMenuByCategory extends FoodOrderingEvent {
  final String category;

  const FilterMenuByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

// Cart Events
class AddToCart extends FoodOrderingEvent {
  final FoodItem foodItem;
  final int quantity;
  final List<String> specialInstructions;

  const AddToCart({
    required this.foodItem,
    this.quantity = 1,
    this.specialInstructions = const [],
  });

  @override
  List<Object?> get props => [foodItem, quantity, specialInstructions];
}

class RemoveFromCart extends FoodOrderingEvent {
  final String cartItemId;

  const RemoveFromCart(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}

class UpdateCartItemQuantity extends FoodOrderingEvent {
  final String cartItemId;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.cartItemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartItemId, quantity];
}

class ClearCart extends FoodOrderingEvent {
  const ClearCart();
}

// Order Events
class PlaceOrder extends FoodOrderingEvent {
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final String? specialInstructions;

  const PlaceOrder({
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    this.specialInstructions,
  });

  @override
  List<Object?> get props => [
    customerName,
    customerPhone,
    deliveryAddress,
    specialInstructions,
  ];
}

class UpdateOrderStatus extends FoodOrderingEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}

// Navigation Events
class NavigateToRestaurants extends FoodOrderingEvent {
  const NavigateToRestaurants();
}

class NavigateToMenu extends FoodOrderingEvent {
  final String restaurantId;

  const NavigateToMenu(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}

class NavigateToCart extends FoodOrderingEvent {
  const NavigateToCart();
}

class NavigateToCheckout extends FoodOrderingEvent {
  const NavigateToCheckout();
}

class NavigateToOrderConfirmation extends FoodOrderingEvent {
  const NavigateToOrderConfirmation();
}
