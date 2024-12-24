import 'dart:developer';

import 'package:produce_pos/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {
  final SupabaseClient supabase = Supabase.instance.client;
  Future<List<Product>> fetchFavorites() async {
    List<Product> favorites = [];
    try {
      final response = await supabase.from('favorite_products').select();

      favorites = (response as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } on PostgrestException catch (error) {
      print("message: ${error.message}");
    } catch (e) {
      print("message: unexpectedErrorMessage $e");
    }
    return favorites;
  }

  Future<void> addFavorite(int productId) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      // Handle unauthenticated state
      print('User is not authenticated');
      return;
    }

    final userId = user.id;
    try {
      final res = await supabase
          .from('favorite_products')
          .insert({"product_id": productId, 'user_id': userId}).select();

      log('Favorite added: $res');
    } catch (e) {
      log("Error adding favorite: $e");
    }
  }

  Future<void> removeFavorite(int productId) async {
    final user = supabase.auth.currentUser;
    print(productId);
    try {
      await supabase
          .from('favorite_products')
          .delete()
          .match({"product_id": productId, 'user_id': user!.id});
    } catch (error) {
      // error occured
      print(error);
    }
  }
}
