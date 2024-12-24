import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:produce_pos/data/models/category_model.dart';
import 'package:produce_pos/data/services/categories_service.dart';

class CategoriesController extends GetxController {
  final CategoriesService categoriesService = CategoriesService();
  final RxList<Category> categories = RxList<Category>();
  final GetStorage storage = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    // Load cached categories if available
    var cachedProducts = storage.read('categories');
    if (cachedProducts != null) {
      // Ensure data is deserialized correctly
      categories.value = (cachedProducts as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    // Fetch the latest categories
    loadCategories();
  }

  void loadCategories() async {
    var fetchedCategories = await categoriesService.fetchCategories();
    // Save categories as JSON to storage
    storage.write(
      'categories',
      fetchedCategories.map((e) => e.toJson()).toList(),
    );
    categories.value = fetchedCategories; // Update observable categories
  }
}
