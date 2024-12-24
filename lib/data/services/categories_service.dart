import 'package:produce_pos/data/models/category_model.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesService {
  final supabase = Supabase.instance.client;
  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [];
    try {
      final response = await supabase.from('categories').select();

      categories = (response as List)
          .map((category) => Category.fromJson(category))
          .toList();
    } on PostgrestException catch (error) {
      print("message: ${error.message}");
    } catch (_) {
      print("message: unexpectedErrorMessage");
    }
    return categories;
  }
}