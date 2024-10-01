import 'dart:async';

import 'package:produce_pos/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsService {
  final _supabaseClient = Supabase.instance.client;

  var supabase = Supabase.instance.client;
  Stream<List<Product>> subscribeToProducts(String tableName) {
    // Subscribing to all changes in the 'products' table
    var productStream = supabase.from(tableName).stream(primaryKey: [
      'productId'
    ]).map((maps) => maps.map((map) => Product.fromJson(map)).toList());

    return productStream;
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await _supabaseClient.from('products').select();

      final products = (response as List)
          .map((productData) => Product.fromJson(productData))
          .toList();
    } on PostgrestException catch (error) {
      print("message: ${error.message}");
    } catch (_) {
      print("message: unexpectedErrorMessage");
    }
  }
}
