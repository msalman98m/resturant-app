import '../models/restaurant.dart';
import '../models/food_item.dart';

class RestaurantService {
  // Mock data for demonstration
  static final List<Restaurant> _mockRestaurants = [
    Restaurant(
      id: '1',
      name: 'Bella Vista Italian',
      description: 'Authentic Italian cuisine with fresh ingredients',
      imageUrl:
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=80',
      address: '123 Main St, Downtown',
      rating: 4.5,
      reviewCount: 128,
      deliveryTime: 25,
      deliveryFee: 2.99,
      minimumOrder: 15.0,
      categories: ['Italian', 'Pasta', 'Pizza'],
      cuisineType: 'Italian',
      phoneNumber: '+1-555-0123',
      menu: [
        FoodItem(
          id: '1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce, mozzarella, and basil',
          price: 16.99,
          imageUrl:
              'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Pizza',
          isVegetarian: true,
          preparationTime: 15,
          rating: 4.7,
          reviewCount: 45,
        ),
        FoodItem(
          id: '2',
          name: 'Spaghetti Carbonara',
          description: 'Creamy pasta with eggs, cheese, and pancetta',
          price: 18.99,
          imageUrl:
              'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Pasta',
          preparationTime: 20,
          rating: 4.6,
          reviewCount: 32,
        ),
        FoodItem(
          id: '3',
          name: 'Chicken Parmigiana',
          description: 'Breaded chicken breast with marinara and mozzarella',
          price: 22.99,
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Main Course',
          preparationTime: 25,
          rating: 4.8,
          reviewCount: 28,
        ),
      ],
    ),
    Restaurant(
      id: '2',
      name: 'Sushi Zen',
      description: 'Fresh sushi and Japanese cuisine',
      imageUrl:
          'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=80',
      address: '456 Oak Ave, Midtown',
      rating: 4.7,
      reviewCount: 95,
      deliveryTime: 30,
      deliveryFee: 3.99,
      minimumOrder: 20.0,
      categories: ['Japanese', 'Sushi', 'Asian'],
      cuisineType: 'Japanese',
      phoneNumber: '+1-555-0456',
      menu: [
        FoodItem(
          id: '4',
          name: 'California Roll',
          description: 'Crab, avocado, and cucumber roll',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Sushi',
          isVegetarian: false,
          preparationTime: 10,
          rating: 4.5,
          reviewCount: 67,
        ),
        FoodItem(
          id: '5',
          name: 'Salmon Nigiri',
          description: 'Fresh salmon over seasoned rice',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Sushi',
          preparationTime: 8,
          rating: 4.8,
          reviewCount: 43,
        ),
        FoodItem(
          id: '6',
          name: 'Chicken Teriyaki',
          description: 'Grilled chicken with teriyaki sauce and rice',
          price: 15.99,
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300',
          category: 'Main Course',
          preparationTime: 18,
          rating: 4.4,
          reviewCount: 25,
        ),
      ],
    ),
    Restaurant(
      id: '3',
      name: 'Burger Palace',
      description: 'Gourmet burgers and American classics',
      imageUrl:
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=80',
      address: '789 Pine St, Uptown',
      rating: 4.3,
      reviewCount: 156,
      deliveryTime: 20,
      deliveryFee: 1.99,
      minimumOrder: 12.0,
      categories: ['American', 'Burgers', 'Fast Food'],
      cuisineType: 'American',
      phoneNumber: '+1-555-0789',
      menu: [
        FoodItem(
          id: '7',
          name: 'Classic Cheeseburger',
          description: 'Beef patty with cheese, lettuce, tomato, and onion',
          price: 13.99,
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Burgers',
          preparationTime: 12,
          rating: 4.6,
          reviewCount: 89,
        ),
        FoodItem(
          id: '8',
          name: 'BBQ Bacon Burger',
          description: 'Beef patty with BBQ sauce, bacon, and cheddar',
          price: 16.99,
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Burgers',
          preparationTime: 15,
          rating: 4.7,
          reviewCount: 54,
        ),
        FoodItem(
          id: '9',
          name: 'Veggie Burger',
          description: 'Plant-based patty with fresh vegetables',
          price: 11.99,
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
          category: 'Burgers',
          isVegetarian: true,
          isVegan: true,
          preparationTime: 10,
          rating: 4.2,
          reviewCount: 23,
        ),
      ],
    ),
  ];

  Future<List<Restaurant>> getRestaurants() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockRestaurants);
  }

  Future<Restaurant?> getRestaurantById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockRestaurants.firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<FoodItem>> getMenu(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final restaurant = _mockRestaurants.firstWhere(
        (restaurant) => restaurant.id == restaurantId,
      );
      return List.from(restaurant.menu);
    } catch (e) {
      throw Exception('Restaurant not found');
    }
  }

  Future<List<FoodItem>> getFoodItemById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final allItems = _mockRestaurants
        .expand((restaurant) => restaurant.menu)
        .where((item) => item.id == id)
        .toList();
    return allItems;
  }
}
