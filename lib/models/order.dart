import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'restaurant.dart';
import 'cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final Restaurant restaurant;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String? specialInstructions;

  const Order({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDeliveryTime,
    this.specialInstructions,
  });

  factory Order.create({
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    required Restaurant restaurant,
    required List<CartItem> items,
    required double deliveryFee,
    required double tax,
    String? specialInstructions,
  }) {
    const uuid = Uuid();
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final total = subtotal + deliveryFee + tax;

    return Order(
      id: uuid.v4(),
      customerName: customerName,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      restaurant: restaurant,
      items: List.from(items),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      total: total,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
      estimatedDeliveryTime: DateTime.now().add(
        Duration(minutes: restaurant.deliveryTime),
      ),
      specialInstructions: specialInstructions,
    );
  }

  Order copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
    Restaurant? restaurant,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? total,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? estimatedDeliveryTime,
    String? specialInstructions,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      restaurant: restaurant ?? this.restaurant,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
    id,
    customerName,
    customerPhone,
    deliveryAddress,
    restaurant,
    items,
    subtotal,
    deliveryFee,
    tax,
    total,
    status,
    createdAt,
    estimatedDeliveryTime,
    specialInstructions,
  ];
}
