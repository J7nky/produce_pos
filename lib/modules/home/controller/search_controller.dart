import 'package:get/get.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/modules/home/controller/products_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchControllerr extends GetxController {
  RxList<Product> filteredProducts = RxList<Product>();
  RxList<String> recentSearches =
      <String>[].obs; // Ensure it's an observable list

  ProductsController productsController = Get.put(ProductsController());
  // Function to query products based on search input

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadRecentSearches();
  }

  void queryProducts(String query) {
    if (query.isEmpty) {
      // Reset filtered list when query is empty
      filteredProducts.clear();
    } else {
      addRecentSearch(query);
      filteredProducts.assignAll(
        productsController.products.where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

// Add query to recent searches and save using SharedPreferences
  void addRecentSearch(String query) async {
    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);

      // Keep only the last 5 recent searches
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }

      await saveRecentSearches();
    }
  }

  // Save recent searches to SharedPreferences
  Future<void> saveRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', recentSearches);
  }

  // Load recent searches from SharedPreferences
  Future<void> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedSearches = prefs.getStringList('recentSearches');

    if (storedSearches != null) {
      recentSearches.assignAll(storedSearches);
    }
  }
}
