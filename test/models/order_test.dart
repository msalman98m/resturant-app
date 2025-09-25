import 'package:flutter_test/flutter_test.dart';
import 'package:resturant_app/models/order.dart';
import 'package:resturant_app/models/restaurant.dart';
import 'package:resturant_app/models/cart_item.dart';
import 'package:resturant_app/models/food_item.dart';

void main() {
  group('Order', () {
    late Restaurant mockRestaurant;
    late List<CartItem> mockCartItems;

    setUp(() {
      mockRestaurant = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        description: 'Test Description',
        imageUrl: 'https://example.com/restaurant.jpg',
        address: 'Test Address',
        phoneNumber: '+1234567890',
        cuisineType: 'Test Cuisine',
        deliveryTime: 30,
      );

      final mockFoodItem = FoodItem(
        id: '1',
        name: 'Test Food',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/food.jpg',
        category: 'Test Category',
      );

      mockCartItems = [
        CartItem(id: 'cart1', foodItem: mockFoodItem, quantity: 2),
      ];
    });

    test('should create Order using factory method', () {
      final order = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
        specialInstructions: 'Ring doorbell twice',
      );

      expect(order.customerName, 'John Doe');
      expect(order.customerPhone, '+1234567890');
      expect(order.deliveryAddress, '123 Main St');
      expect(order.restaurant, mockRestaurant);
      expect(order.items, mockCartItems);
      expect(order.subtotal, 20.0); // 2 * 10.0
      expect(order.deliveryFee, 2.99);
      expect(order.tax, 1.60);
      expect(order.total, 24.59); // 20.0 + 2.99 + 1.60
      expect(order.status, OrderStatus.pending);
      expect(order.specialInstructions, 'Ring doorbell twice');
      expect(order.id, isNotEmpty);
      expect(order.createdAt, isA<DateTime>());
      expect(order.estimatedDeliveryTime, isA<DateTime>());
    });

    test('should calculate total correctly', () {
      final order = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
      );

      expect(
        order.total,
        equals(order.subtotal + order.deliveryFee + order.tax),
      );
    });

    test(
      'should set estimated delivery time based on restaurant delivery time',
      () {
        final order = Order.create(
          customerName: 'John Doe',
          customerPhone: '+1234567890',
          deliveryAddress: '123 Main St',
          restaurant: mockRestaurant,
          items: mockCartItems,
          deliveryFee: 2.99,
          tax: 1.60,
        );

        final expectedDeliveryTime = order.createdAt.add(
          Duration(minutes: mockRestaurant.deliveryTime),
        );

        expect(order.estimatedDeliveryTime, equals(expectedDeliveryTime));
      },
    );

    test('should support equality comparison', () {
      final order1 = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
      );

      final order2 = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
      );

      // Different IDs, so not equal
      expect(order1, isNot(equals(order2)));
    });

    test('should create copy with updated values', () {
      final originalOrder = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
      );

      final updatedOrder = originalOrder.copyWith(
        status: OrderStatus.confirmed,
        specialInstructions: 'Updated instructions',
      );

      expect(updatedOrder.id, originalOrder.id);
      expect(updatedOrder.customerName, originalOrder.customerName);
      expect(updatedOrder.status, OrderStatus.confirmed);
      expect(updatedOrder.specialInstructions, 'Updated instructions');
    });

    test('should include all properties in props', () {
      final order = Order.create(
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        deliveryAddress: '123 Main St',
        restaurant: mockRestaurant,
        items: mockCartItems,
        deliveryFee: 2.99,
        tax: 1.60,
        specialInstructions: 'Ring doorbell',
      );

      expect(order.props, [
        order.id,
        'John Doe',
        '+1234567890',
        '123 Main St',
        mockRestaurant,
        mockCartItems,
        20.0,
        2.99,
        1.60,
        24.59,
        OrderStatus.pending,
        order.createdAt,
        order.estimatedDeliveryTime,
        'Ring doorbell',
      ]);
    });
  });
}
