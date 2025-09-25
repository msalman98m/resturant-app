# Food Delivery App

A comprehensive Flutter food ordering application built with BloC architecture, featuring a complete workflow from restaurant selection to order confirmation.

## Features

### 🍕 Complete Ordering Workflow
- **Restaurant Discovery**: Browse local restaurants with search and filtering
- **Menu Browsing**: View restaurant menus with categories and food details
- **Cart Management**: Add/remove items, update quantities, special instructions
- **Checkout Process**: Customer information collection and order placement
- **Order Confirmation**: Detailed order summary and confirmation

### 🏗️ Architecture & Design
- **Bloc Pattern**: Clean separation of business logic and UI
- **SOLID Principles**: Well-structured, maintainable codebase
- **Error Handling**: Comprehensive error management throughout the workflow
- **Modern UI**: Beautiful, responsive design with Google Fonts and Material Design
- **State Management**: Reactive state management with flutter_bloc

### 🧪 Testing
- **Unit Tests**: Comprehensive test coverage for BloC logic
- **Model Tests**: Thorough testing of data models
- **Mock Services**: Isolated testing with mock dependencies

## Project Structure

```
lib/
├── bloc/                    # BloC architecture
│   ├── food_ordering_bloc.dart
│   ├── food_ordering_event.dart
│   └── food_ordering_state.dart
├── models/                  # Data models
│   ├── food_item.dart
│   ├── restaurant.dart
│   ├── cart_item.dart
│   └── order.dart
├── services/               # Business logic services
│   ├── restaurant_service.dart
│   └── order_service.dart
├── screens/                # UI screens
│   ├── restaurant_list_screen.dart
│   ├── menu_screen.dart
│   ├── cart_screen.dart
│   ├── checkout_screen.dart
│   └── order_confirmation_screen.dart
└── main.dart              # App entry point

test/
├── bloc/                   # BloC tests
│   └── food_ordering_bloc_test.dart
└── models/                 # Model tests
    ├── food_item_test.dart
    └── order_test.dart
```

## Key Components

### Data Models
- **Restaurant**: Restaurant information with menu and delivery details
- **FoodItem**: Individual food items with pricing and dietary information
- **CartItem**: Shopping cart items with quantities and special instructions
- **Order**: Complete order information with customer and delivery details

### BloC Architecture
- **Events**: User actions and system events
- **States**: Application state representation
- **Bloc**: Business logic and state management

### UI Screens
1. **Restaurant List**: Browse and search restaurants
2. **Menu Screen**: View restaurant menu with filtering
3. **Cart Screen**: Manage cart items and quantities
4. **Checkout Screen**: Customer information and order placement
5. **Order Confirmation**: Order summary and confirmation

## Features in Detail

### Restaurant Discovery
- Search restaurants by name or cuisine
- Filter by categories (Italian, Japanese, American)
- View restaurant ratings, delivery time, and fees
- Restaurant status (open/closed) indicators

### Menu Management
- Category-based menu filtering
- Food item details with images and descriptions
- Dietary information (vegetarian, vegan)
- Special instructions support

### Cart Functionality
- Add/remove items with quantity controls
- Special instructions for each item
- Real-time total calculation
- Cart persistence during session

### Order Processing
- Customer information validation
- Delivery address collection
- Order total calculation (subtotal + delivery + tax)
- Order confirmation with estimated delivery time

### Error Handling
- Network error management
- Form validation
- User-friendly error messages

## Dependencies

### Core Dependencies
- `flutter_bloc: ^8.1.3` - State management
- `equatable: ^2.0.5` - Value equality
- `uuid: ^4.2.1` - Unique identifiers

### UI Dependencies
- `google_fonts: ^6.1.0` - Typography
- `cached_network_image: ^3.3.0` - Image caching

### Testing Dependencies
- `bloc_test: ^9.1.5` - BloC testing
- `mocktail: ^1.0.1` - Mocking framework

## Design Principles

### SOLID Principles Implementation
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Derived classes are substitutable for base classes
- **Interface Segregation**: Clients depend only on interfaces they use
- **Dependency Inversion**: Depend on abstractions, not concretions

### Clean Architecture
- **Presentation Layer**: UI screens and widgets
- **Business Logic Layer**: BloC and services
- **Data Layer**: Models and repositories

## Testing Strategy

### Unit Tests
- BloC logic testing with mock services
- Model validation and behavior testing
- Event and state transition testing

### Test Coverage
- BloC events and state management
- Model creation and manipulation
- Service layer functionality
- Error handling scenarios

## Future Enhancements

### Potential Features
- User authentication and profiles
- Order history and tracking
- Payment integration
- Push notifications
- Restaurant reviews and ratings
- Real-time order tracking
- Multiple payment methods
- Loyalty programs

### Technical Improvements
- Offline support with local storage
- Image optimization and caching
- Performance monitoring
- Analytics integration
- Internationalization support

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- BloC library for state management
- Google Fonts for typography
- Material Design for UI components