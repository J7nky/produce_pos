import 'dart:math';

import 'package:produce_pos/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriceGenerator {
  static const double minMultiplier = 1.3; // Minimum 30% increase
  static const double maxMultiplier = 1.5; // Maximum 100% increase

  static Future<double> getFakePrice(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if a multiplier already exists for this product
    String multiplierKey = "multiplier_${product.productId}";
    double multiplier = prefs.getDouble(multiplierKey) ?? _generateMultiplier();

    // If the multiplier is new, save it so it remains consistent across sessions
    if (!prefs.containsKey(multiplierKey)) {
      await prefs.setDouble(multiplierKey, multiplier);
    }

    // Calculate and return the fake price
    double value = (product.price * multiplier).roundToDouble();
    double remainder = value % 500;
    if (remainder >= 250.0) {
      // Round up to the next 500
      return value + (500.0 - remainder);
    } else {
      // Round down to the nearest 500
      return value - remainder;
    }
  }

  // Generate a random multiplier between minMultiplier and maxMultiplier
  static double _generateMultiplier() {
    final random = Random();
    return minMultiplier +
        (maxMultiplier - minMultiplier) * random.nextDouble();
  }
}
