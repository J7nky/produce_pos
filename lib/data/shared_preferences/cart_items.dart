import 'dart:convert';

import 'package:produce_pos/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCartToPreferences(List<CartModel> items) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(items.map((item) => item.toJson()).toList());
  await prefs.setString('cart', jsonString);
}

Future<List<CartModel>> getCartFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('cart');
  if (jsonString != null) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => CartModel.fromJson(json)).toList();
  }
  return [];
}
