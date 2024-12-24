import 'dart:convert';
import 'package:get/get.dart';
import 'package:produce_pos/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <CartModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartFromPreferences();
  }

  double getTotal() {
    double value = 0;
    cartItems.forEach((item) {
      value += item.quantity * item.product.price;
    });
    return value;
  }

  // Fetch cart from SharedPreferences
  Future<void> getCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      cartItems.value =
          jsonList.map((json) => CartModel.fromJson(json)).toList();
    }
  }

  // Save cart to SharedPreferences
  Future<void> saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cart', jsonString);
  }

  // Add item to cart
  void addItem(CartModel item) {
    var existingItem = cartItems.firstWhereOrNull(
      (element) => element.product.productId == item.product.productId,
    );

    if (existingItem != null) {
      // Update quantity if the item exists
      existingItem.quantity += 1;
    } else {
      // Add new item
      cartItems.add(item);
    }
    cartItems.refresh();
    saveCartToPreferences(); // Persist changes
  }

  // Remove item from cart
  void removeItem(CartModel item) {
    var existingItem = cartItems.firstWhereOrNull(
      (element) => element.product.productId == item.product.productId,
    );

    if (existingItem!.quantity > 1) {
      // Update quantity if the item exists
      existingItem.quantity -= 1;
    } else {
      // Add new item
      cartItems.remove(item);
    }
    cartItems.refresh();
    saveCartToPreferences(); // Persist changes
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
    saveCartToPreferences(); // Persist changes
  }
}
