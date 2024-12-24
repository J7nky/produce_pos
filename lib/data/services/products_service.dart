import 'dart:async';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  // Subscribe to changes and get initial data from the specified table
  Stream<List<Product>> subscribeToProducts(String tableName) {
    // Create a StreamController to manage the stream of products
    final controller = StreamController<List<Product>>();

    // Fetch the initial data
    _fetchInitialData(tableName, controller);

    // Subscribe to changes in the specified table using onPostgresChanges
    final subscription = supabase
        .channel('public:$tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.all, // Listen for all change events
          schema: 'public',
          table: tableName,
          callback: (payload) async {
            print('Change received: ${payload.toString()}');

            // Fetch the latest data after each change event
            await _fetchUpdatedData(tableName, controller);
          },
        )
        .subscribe();

    // Clean up the subscription when the stream is no longer needed
    controller.onCancel = () {
      supabase.removeChannel(subscription);
      controller.close();
    };

    return controller.stream;
  }

  // Helper function to fetch initial data and add to the stream
  Future<void> _fetchInitialData(
      String tableName, StreamController<List<Product>> controller) async {
    final response = await supabase.from(tableName).select();

    if (response is List) {
      final products = response.map((item) => Product.fromJson(item)).toList();
      controller.add(products);
    } else {
      controller.addError('Failed to fetch initial data');
    }
  }

  // Helper function to fetch updated data after each change event
  Future<void> _fetchUpdatedData(
      String tableName, StreamController<List<Product>> controller) async {
    final response = await supabase.from(tableName).select();

    if (response is List) {
      final products = response.map((item) => Product.fromJson(item)).toList();
      controller.add(products);
    } else {
      controller.addError('Failed to fetch updated data');
    }
  }
}
