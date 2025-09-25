import 'package:equatable/equatable.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

enum FoodOrderingStatus {
  initial,
  loading,
  loaded,
  error,
  ordering,
  orderPlaced,
}

class FoodOrderingState extends Equatable {
  final FoodOrderingStatus status;
  final List<Restaurant> restaurants;
  final Restaurant? selectedRestaurant;
  final List<FoodItem> menu;
  final List<CartItem> cart;
  final Order? currentOrder;
  final String? errorMessage;
  final String? selectedCategory;
  final String searchQuery;
  final double cartTotal;
  final double deliveryFee;
  final double tax;

  const FoodOrderingState({
    this.status = FoodOrderingStatus.initial,
    this.restaurants = const [],
    this.selectedRestaurant,
    this.menu = const [],
    this.cart = const [],
    this.currentOrder,
    this.errorMessage,
    this.selectedCategory,
    this.searchQuery = '',
    this.cartTotal = 0.0,
    this.deliveryFee = 2.99,
    this.tax = 0.0,
  });

  FoodOrderingState copyWith({
    FoodOrderingStatus? status,
    List<Restaurant>? restaurants,
    Restaurant? selectedRestaurant,
    List<FoodItem>? menu,
    List<CartItem>? cart,
    Order? currentOrder,
    String? errorMessage,
    String? selectedCategory,
    String? searchQuery,
    double? cartTotal,
    double? deliveryFee,
    double? tax,
  }) {
    return FoodOrderingState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      menu: menu ?? this.menu,
      cart: cart ?? this.cart,
      currentOrder: currentOrder ?? this.currentOrder,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      cartTotal: cartTotal ?? this.cartTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
    );
  }

  bool get isLoading => status == FoodOrderingStatus.loading;
  bool get hasError => status == FoodOrderingStatus.error;
  bool get isOrdering => status == FoodOrderingStatus.ordering;
  bool get hasOrder => currentOrder != null;
  bool get isCartEmpty => cart.isEmpty;
  bool get canPlaceOrder => cart.isNotEmpty && selectedRestaurant != null;

  double get totalAmount => cartTotal + deliveryFee + tax;

  List<Restaurant> get filteredRestaurants {
    var filtered = restaurants;

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filtered = filtered
          .where(
            (restaurant) => restaurant.categories.contains(selectedCategory),
          )
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (restaurant) =>
                restaurant.name.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                restaurant.cuisineType.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  List<FoodItem> get filteredMenu {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return menu;
    }
    return menu.where((item) => item.category == selectedCategory).toList();
  }

  @override
  List<Object?> get props => [
    status,
    restaurants,
    selectedRestaurant,
    menu,
    cart,
    currentOrder,
    errorMessage,
    selectedCategory,
    searchQuery,
    cartTotal,
    deliveryFee,
    tax,
  ];
}
