import 'package:produce_pos/core/enums/order_status.dart';
import 'package:produce_pos/core/enums/product_type.dart';
import 'package:produce_pos/data/models/product_model.dart';

class Orders {
  final int orderId;
  final String userId;
  final double total;
  final OrderStatus orderStatus;
  final String address;
  Orders(this.orderId, this.userId, this.total, this.orderStatus, this.address);
}

class OrderDetails {
  final Product product;
  final int orderId;
  final int quantity;
  final ProductType productType;

  OrderDetails(this.product, this.orderId, this.quantity, this.productType);
}
