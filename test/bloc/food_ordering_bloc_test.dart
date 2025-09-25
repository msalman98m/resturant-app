import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resturant_app/bloc/food_ordering_bloc.dart';
import 'package:resturant_app/bloc/food_ordering_event.dart';
import 'package:resturant_app/bloc/food_ordering_state.dart';
import 'package:resturant_app/models/food_item.dart';
import 'package:resturant_app/models/restaurant.dart';
import 'package:resturant_app/models/order.dart';
import 'package:resturant_app/services/restaurant_service.dart';
import 'package:resturant_app/services/order_service.dart';

class MockRestaurantService extends Mock implements RestaurantService {}

class MockOrderService extends Mock implements OrderService {}

void main() {
  group('FoodOrderingBloc', () {
    late MockRestaurantService mockRestaurantService;
    late MockOrderService mockOrderService;
    late FoodOrderingBloc foodOrderingBloc;

    setUp(() {
      mockRestaurantService = MockRestaurantService();
      mockOrderService = MockOrderService();
      foodOrderingBloc = FoodOrderingBloc(
        restaurantService: mockRestaurantService,
        orderService: mockOrderService,
      );
    });

    tearDown(() {
      foodOrderingBloc.close();
    });

    test('initial state is correct', () {
      expect(foodOrderingBloc.state, const FoodOrderingState());
    });

    group('LoadRestaurants', () {
      final mockRestaurants = [
        Restaurant(
          id: '1',
          name: 'Test Restaurant',
          description: 'Test Description',
          imageUrl: 'https://example.com/image.jpg',
          address: 'Test Address',
          phoneNumber: '+1234567890',
          cuisineType: 'Test Cuisine',
        ),
      ];

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits [loading, loaded] when LoadRestaurants is added successfully',
        build: () {
          when(
            () => mockRestaurantService.getRestaurants(),
          ).thenAnswer((_) async => mockRestaurants);
          return foodOrderingBloc;
        },
        act: (bloc) => bloc.add(const LoadRestaurants()),
        expect: () => [
          const FoodOrderingState(status: FoodOrderingStatus.loading),
          FoodOrderingState(
            status: FoodOrderingStatus.loaded,
            restaurants: mockRestaurants,
          ),
        ],
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits [loading, error] when LoadRestaurants fails',
        build: () {
          when(
            () => mockRestaurantService.getRestaurants(),
          ).thenThrow(Exception('Network error'));
          return foodOrderingBloc;
        },
        act: (bloc) => bloc.add(const LoadRestaurants()),
        expect: () => [
          const FoodOrderingState(status: FoodOrderingStatus.loading),
          const FoodOrderingState(
            status: FoodOrderingStatus.error,
            errorMessage:
                'Failed to load restaurants: Exception: Network error',
          ),
        ],
      );
    });

    group('SelectRestaurant', () {
      final mockRestaurant = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        address: 'Test Address',
        phoneNumber: '+1234567890',
        cuisineType: 'Test Cuisine',
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with selected restaurant',
        build: () => foodOrderingBloc,
        act: (bloc) => bloc.add(SelectRestaurant(mockRestaurant)),
        expect: () => [FoodOrderingState(selectedRestaurant: mockRestaurant)],
      );
    });

    group('AddToCart', () {
      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with added cart item',
        build: () => foodOrderingBloc,
        act: (bloc) => bloc.add(AddToCart(foodItem: mockFoodItem, quantity: 2)),
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.length == 1 &&
                state.cart.first.foodItem == mockFoodItem &&
                state.cart.first.quantity == 2 &&
                state.cartTotal == 20.0;
          }),
        ],
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'updates existing cart item quantity when item already exists',
        build: () {
          // Add initial item to cart
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
          return foodOrderingBloc;
        },
        act: (bloc) => bloc.add(AddToCart(foodItem: mockFoodItem, quantity: 2)),
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.length == 1 &&
                state.cart.first.quantity == 3 &&
                state.cartTotal == 30.0;
          }),
        ],
      );
    });

    group('RemoveFromCart', () {
      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with removed cart item',
        build: () {
          // Add item to cart first
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
          return foodOrderingBloc;
        },
        act: (bloc) {
          final cartItemId = bloc.state.cart.first.id;
          bloc.add(RemoveFromCart(cartItemId));
        },
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.isEmpty && state.cartTotal == 0.0;
          }),
        ],
      );
    });

    group('UpdateCartItemQuantity', () {
      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with updated cart item quantity',
        build: () {
          // Add item to cart first
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
          return foodOrderingBloc;
        },
        act: (bloc) {
          final cartItemId = bloc.state.cart.first.id;
          bloc.add(UpdateCartItemQuantity(cartItemId: cartItemId, quantity: 3));
        },
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.first.quantity == 3 && state.cartTotal == 30.0;
          }),
        ],
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'removes item when quantity is set to 0',
        build: () {
          // Add item to cart first
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
          return foodOrderingBloc;
        },
        act: (bloc) {
          final cartItemId = bloc.state.cart.first.id;
          bloc.add(UpdateCartItemQuantity(cartItemId: cartItemId, quantity: 0));
        },
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.isEmpty && state.cartTotal == 0.0;
          }),
        ],
      );
    });

    group('ClearCart', () {
      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with empty cart',
        build: () {
          // Add item to cart first
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
          return foodOrderingBloc;
        },
        act: (bloc) => bloc.add(const ClearCart()),
        expect: () => [
          predicate<FoodOrderingState>((state) {
            return state.cart.isEmpty && state.cartTotal == 0.0;
          }),
        ],
      );
    });

    group('PlaceOrder', () {
      final mockRestaurant = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        address: 'Test Address',
        phoneNumber: '+1234567890',
        cuisineType: 'Test Cuisine',
      );

      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      final mockOrder = Order.create(
        customerName: 'Test Customer',
        customerPhone: '+1234567890',
        deliveryAddress: 'Test Address',
        restaurant: mockRestaurant,
        items: [],
        deliveryFee: 2.99,
        tax: 0.0,
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits [ordering, orderPlaced] when PlaceOrder is successful',
        build: () {
          when(
            () => mockOrderService.placeOrder(any()),
          ).thenAnswer((_) async => mockOrder);
          return foodOrderingBloc;
        },
        setUp: () {
          // Set up cart and restaurant
          foodOrderingBloc.add(SelectRestaurant(mockRestaurant));
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
        },
        act: (bloc) => bloc.add(
          const PlaceOrder(
            customerName: 'Test Customer',
            customerPhone: '+1234567890',
            deliveryAddress: 'Test Address',
          ),
        ),
        expect: () => [
          predicate<FoodOrderingState>(
            (state) => state.status == FoodOrderingStatus.ordering,
          ),
          predicate<FoodOrderingState>(
            (state) =>
                state.status == FoodOrderingStatus.orderPlaced &&
                state.currentOrder != null,
          ),
        ],
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits [ordering, error] when PlaceOrder fails',
        build: () {
          when(
            () => mockOrderService.placeOrder(any()),
          ).thenThrow(Exception('Order failed'));
          return foodOrderingBloc;
        },
        setUp: () {
          // Set up cart and restaurant
          foodOrderingBloc.add(SelectRestaurant(mockRestaurant));
          foodOrderingBloc.add(AddToCart(foodItem: mockFoodItem, quantity: 1));
        },
        act: (bloc) => bloc.add(
          const PlaceOrder(
            customerName: 'Test Customer',
            customerPhone: '+1234567890',
            deliveryAddress: 'Test Address',
          ),
        ),
        expect: () => [
          predicate<FoodOrderingState>(
            (state) => state.status == FoodOrderingStatus.ordering,
          ),
          predicate<FoodOrderingState>(
            (state) =>
                state.status == FoodOrderingStatus.error &&
                state.errorMessage != null,
          ),
        ],
      );

      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits error when cart is empty',
        build: () => foodOrderingBloc,
        act: (bloc) => bloc.add(
          const PlaceOrder(
            customerName: 'Test Customer',
            customerPhone: '+1234567890',
            deliveryAddress: 'Test Address',
          ),
        ),
        expect: () => [
          predicate<FoodOrderingState>(
            (state) =>
                state.errorMessage != null &&
                state.errorMessage!.contains('Cart is empty'),
          ),
        ],
      );
    });

    group('SearchRestaurants', () {
      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with search query',
        build: () => foodOrderingBloc,
        act: (bloc) => bloc.add(const SearchRestaurants('pizza')),
        expect: () => [const FoodOrderingState(searchQuery: 'pizza')],
      );
    });

    group('FilterRestaurantsByCategory', () {
      blocTest<FoodOrderingBloc, FoodOrderingState>(
        'emits state with selected category',
        build: () => foodOrderingBloc,
        act: (bloc) => bloc.add(const FilterRestaurantsByCategory('Italian')),
        expect: () => [const FoodOrderingState(selectedCategory: 'Italian')],
      );
    });
  });
}
