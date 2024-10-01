import 'dart:async';

import 'package:get/get.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/data/services/products_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsController extends GetxController {
  final _supabaseClient = Supabase.instance.client;
  final RxList<Product> products = RxList<Product>();
  StreamSubscription<List<Product>>? _subscription;

  ProductsService productService = ProductsService();

  Stream<List<Product>> productsStream() {
    var stream = productService.subscribeToProducts("Products");
    _subscription = stream.listen((data) {
      products.value = data.map((map) => map).toList();
    });
    return stream;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
