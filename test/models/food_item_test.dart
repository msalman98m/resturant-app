import 'package:flutter_test/flutter_test.dart';
import 'package:resturant_app/models/food_item.dart';

void main() {
  group('FoodItem', () {
    test('should create FoodItem with required parameters', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
      );

      expect(foodItem.id, '1');
      expect(foodItem.name, 'Pizza');
      expect(foodItem.description, 'Delicious pizza');
      expect(foodItem.price, 15.99);
      expect(foodItem.imageUrl, 'https://example.com/pizza.jpg');
      expect(foodItem.category, 'Italian');
      expect(foodItem.isVegetarian, false);
      expect(foodItem.isVegan, false);
      expect(foodItem.preparationTime, 15);
      expect(foodItem.rating, 4.0);
      expect(foodItem.reviewCount, 0);
    });

    test('should create FoodItem with all parameters', () {
      const foodItem = FoodItem(
        id: '2',
        name: 'Veggie Burger',
        description: 'Plant-based burger',
        price: 12.99,
        imageUrl: 'https://example.com/burger.jpg',
        category: 'American',
        isVegetarian: true,
        isVegan: true,
        preparationTime: 10,
        rating: 4.5,
        reviewCount: 25,
      );

      expect(foodItem.id, '2');
      expect(foodItem.name, 'Veggie Burger');
      expect(foodItem.isVegetarian, true);
      expect(foodItem.isVegan, true);
      expect(foodItem.preparationTime, 10);
      expect(foodItem.rating, 4.5);
      expect(foodItem.reviewCount, 25);
    });

    test('should support equality comparison', () {
      const foodItem1 = FoodItem(
        id: '1',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
      );

      const foodItem2 = FoodItem(
        id: '1',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
      );

      const foodItem3 = FoodItem(
        id: '2',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
      );

      expect(foodItem1, equals(foodItem2));
      expect(foodItem1, isNot(equals(foodItem3)));
    });

    test('should create copy with updated values', () {
      const originalFoodItem = FoodItem(
        id: '1',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
      );

      final updatedFoodItem = originalFoodItem.copyWith(
        name: 'Margherita Pizza',
        price: 18.99,
        isVegetarian: true,
      );

      expect(updatedFoodItem.id, '1');
      expect(updatedFoodItem.name, 'Margherita Pizza');
      expect(updatedFoodItem.description, 'Delicious pizza');
      expect(updatedFoodItem.price, 18.99);
      expect(updatedFoodItem.isVegetarian, true);
      expect(updatedFoodItem.isVegan, false);
    });

    test('should include all properties in props', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Pizza',
        description: 'Delicious pizza',
        price: 15.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Italian',
        isVegetarian: true,
        isVegan: false,
        preparationTime: 20,
        rating: 4.5,
        reviewCount: 10,
      );

      expect(foodItem.props, [
        '1',
        'Pizza',
        'Delicious pizza',
        15.99,
        'https://example.com/pizza.jpg',
        'Italian',
        true,
        false,
        20,
        4.5,
        10,
      ]);
    });
  });
}
