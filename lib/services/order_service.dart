import '../models/order.dart';

class OrderService {
  // Mock order storage
  static final List<Order> _orders = [];

  Future<Order> placeOrder(Order order) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate potential failure (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Order placement failed. Please try again.');
    }

    _orders.add(order);
    return order;
  }

  Future<Order?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Order>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_orders);
  }

  Future<Order> updateOrderStatus(String orderId, String status) async {
    await Future.delayed(const Duration(seconds: 1));

    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) {
      throw Exception('Order not found');
    }

    final order = _orders[orderIndex];
    final updatedOrder = order.copyWith(
      status: OrderStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => order.status,
      ),
    );

    _orders[orderIndex] = updatedOrder;
    return updatedOrder;
  }

  Future<bool> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));

    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) {
      return false;
    }

    final order = _orders[orderIndex];
    if (order.status == OrderStatus.delivered ||
        order.status == OrderStatus.cancelled) {
      return false;
    }

    final updatedOrder = order.copyWith(status: OrderStatus.cancelled);
    _orders[orderIndex] = updatedOrder;
    return true;
  }
}
