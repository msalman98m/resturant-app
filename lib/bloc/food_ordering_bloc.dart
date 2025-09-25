import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'food_ordering_event.dart';
import 'food_ordering_state.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../services/restaurant_service.dart';
import '../services/order_service.dart';

class FoodOrderingBloc extends Bloc<FoodOrderingEvent, FoodOrderingState> {
  final RestaurantService _restaurantService;
  final OrderService _orderService;
  final Uuid _uuid = const Uuid();

  FoodOrderingBloc({
    required RestaurantService restaurantService,
    required OrderService orderService,
  }) : _restaurantService = restaurantService,
       _orderService = orderService,
       super(const FoodOrderingState()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SelectRestaurant>(_onSelectRestaurant);
    on<FilterRestaurantsByCategory>(_onFilterRestaurantsByCategory);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<LoadMenu>(_onLoadMenu);
    on<FilterMenuByCategory>(_onFilterMenuByCategory);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
    on<PlaceOrder>(_onPlaceOrder);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
    on<NavigateToRestaurants>(_onNavigateToRestaurants);
    on<NavigateToMenu>(_onNavigateToMenu);
    on<NavigateToCart>(_onNavigateToCart);
    on<NavigateToCheckout>(_onNavigateToCheckout);
    on<NavigateToOrderConfirmation>(_onNavigateToOrderConfirmation);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<FoodOrderingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodOrderingStatus.loading));

      final restaurants = await _restaurantService.getRestaurants();

      emit(
        state.copyWith(
          status: FoodOrderingStatus.loaded,
          restaurants: restaurants,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage: 'Failed to load restaurants: ${e.toString()}',
        ),
      );
    }
  }

  void _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(selectedRestaurant: event.restaurant));
  }

  void _onFilterRestaurantsByCategory(
    FilterRestaurantsByCategory event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onLoadMenu(
    LoadMenu event,
    Emitter<FoodOrderingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodOrderingStatus.loading));

      final menu = await _restaurantService.getMenu(event.restaurantId);

      emit(
        state.copyWith(
          status: FoodOrderingStatus.loaded,
          menu: menu,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage: 'Failed to load menu: ${e.toString()}',
        ),
      );
    }
  }

  void _onFilterMenuByCategory(
    FilterMenuByCategory event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onAddToCart(AddToCart event, Emitter<FoodOrderingState> emit) {
    try {
      final existingItemIndex = state.cart.indexWhere(
        (item) => item.foodItem.id == event.foodItem.id,
      );

      List<CartItem> updatedCart;

      if (existingItemIndex != -1) {
        // Update existing item
        updatedCart = List.from(state.cart);
        final existingItem = updatedCart[existingItemIndex];
        updatedCart[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + event.quantity,
        );
      } else {
        // Add new item
        final cartItem = CartItem(
          id: _uuid.v4(),
          foodItem: event.foodItem,
          quantity: event.quantity,
          specialInstructions: event.specialInstructions,
        );
        updatedCart = [...state.cart, cartItem];
      }

      final cartTotal = _calculateCartTotal(updatedCart);
      final tax = _calculateTax(cartTotal);

      emit(
        state.copyWith(
          cart: updatedCart,
          cartTotal: cartTotal,
          tax: tax,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to add item to cart: ${e.toString()}',
        ),
      );
    }
  }

  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<FoodOrderingState> emit,
  ) {
    try {
      final updatedCart = state.cart
          .where((item) => item.id != event.cartItemId)
          .toList();

      final cartTotal = _calculateCartTotal(updatedCart);
      final tax = _calculateTax(cartTotal);

      emit(
        state.copyWith(
          cart: updatedCart,
          cartTotal: cartTotal,
          tax: tax,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to remove item from cart: ${e.toString()}',
        ),
      );
    }
  }

  void _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<FoodOrderingState> emit,
  ) {
    try {
      if (event.quantity <= 0) {
        add(RemoveFromCart(event.cartItemId));
        return;
      }

      final updatedCart = state.cart.map((item) {
        if (item.id == event.cartItemId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();

      final cartTotal = _calculateCartTotal(updatedCart);
      final tax = _calculateTax(cartTotal);

      emit(
        state.copyWith(
          cart: updatedCart,
          cartTotal: cartTotal,
          tax: tax,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to update cart item: ${e.toString()}',
        ),
      );
    }
  }

  void _onClearCart(ClearCart event, Emitter<FoodOrderingState> emit) {
    emit(
      state.copyWith(cart: [], cartTotal: 0.0, tax: 0.0, errorMessage: null),
    );
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<FoodOrderingState> emit,
  ) async {
    try {
      if (state.cart.isEmpty || state.selectedRestaurant == null) {
        emit(
          state.copyWith(
            errorMessage:
                'Cannot place order: Cart is empty or no restaurant selected',
          ),
        );
        return;
      }

      emit(state.copyWith(status: FoodOrderingStatus.ordering));

      final order = Order.create(
        customerName: event.customerName,
        customerPhone: event.customerPhone,
        deliveryAddress: event.deliveryAddress,
        restaurant: state.selectedRestaurant!,
        items: state.cart,
        deliveryFee: state.deliveryFee,
        tax: state.tax,
        specialInstructions: event.specialInstructions,
      );

      final placedOrder = await _orderService.placeOrder(order);

      emit(
        state.copyWith(
          status: FoodOrderingStatus.orderPlaced,
          currentOrder: placedOrder,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage: 'Failed to place order: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<FoodOrderingState> emit,
  ) async {
    try {
      if (state.currentOrder == null) return;

      final updatedOrder = await _orderService.updateOrderStatus(
        event.orderId,
        event.status,
      );

      emit(state.copyWith(currentOrder: updatedOrder, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to update order status: ${e.toString()}',
        ),
      );
    }
  }

  void _onNavigateToRestaurants(
    NavigateToRestaurants event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRestaurant: null,
        menu: [],
        selectedCategory: null,
      ),
    );
  }

  void _onNavigateToMenu(
    NavigateToMenu event,
    Emitter<FoodOrderingState> emit,
  ) {
    add(LoadMenu(event.restaurantId));
  }

  void _onNavigateToCart(
    NavigateToCart event,
    Emitter<FoodOrderingState> emit,
  ) {
    // Navigation handled by UI
  }

  void _onNavigateToCheckout(
    NavigateToCheckout event,
    Emitter<FoodOrderingState> emit,
  ) {
    // Navigation handled by UI
  }

  void _onNavigateToOrderConfirmation(
    NavigateToOrderConfirmation event,
    Emitter<FoodOrderingState> emit,
  ) {
    // Navigation handled by UI
  }

  double _calculateCartTotal(List<CartItem> cart) {
    return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double _calculateTax(double subtotal) {
    return subtotal * 0.08; // 8% tax rate
  }
}
