import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/data/services/products_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsController extends GetxController {
  final _supabaseClient = Supabase.instance.client;
  final RxList<Product> products = RxList<Product>();

  final RxList<Product> popularProducts = RxList<Product>();
  StreamSubscription<List<Product>>? _subscription;

  ProductService productService = ProductService();
  final GetStorage storage = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    // Load cached products if available

    List<dynamic>? popularProductsCache =
        storage.read<List<dynamic>>('popular');

    // Start listening to the product stream

    productsStream();

    if (popularProductsCache != null) {
      popularProducts.value =
          (popularProductsCache!.map((e) => Product.fromJson(e)).toList());
    } else {
      popularProductsStream();
    }
  }

  Stream<List<Product>> productsStream() {
    List<dynamic>? cachedProducts = storage.read<List<dynamic>>('products');
    var stream = productService.subscribeToProducts("products");
    _subscription = stream.listen((data) {
      // Update the cache whenever data changes
      if (cachedProducts != null && cachedProducts != data) {
        products.value =
            (cachedProducts.map((e) => Product.fromJson(e)).toList());
      }
      products.value = data;
      storage.write('products', data);
    });
    print(products);
    return stream;
  }

  Stream<List<Product>> popularProductsStream() {
    var stream = productService.subscribeToProducts("products");
    _subscription = stream.listen((data) {
      var filtered = data
        ..sort((a, b) => b.popularityScore.compareTo(a.popularityScore))
        ..length = data.length < 10 ? data.length : 10;
      popularProducts.value = filtered;
      // Update the cache whenever data changes
      storage.write('popular', filtered);
    });
    return stream;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
