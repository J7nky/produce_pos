// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:produce_pos/data/models/product_model.dart';

class CartModel {
  final Product product;
   int quantity;

  CartModel(this.product, this.quantity);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'product': product,
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      Product.fromJson(json['product'] as Map<String, dynamic>),
      json['quantity'] as int,
    );
  }
}
