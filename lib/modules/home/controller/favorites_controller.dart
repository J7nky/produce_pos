import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/data/services/favourite_service.dart';

class FavoritesController extends GetxController {
  final FavoriteService favouritesService = FavoriteService();
  final RxList<Product> favourites = RxList<Product>();
  final GetStorage storage = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    // Load cached products if available
    List<dynamic>? cachedProducts = storage.read<List<dynamic>>('favourites');
    if (cachedProducts!=null) {
      print('12312$cachedProducts');
      favourites.value =
          (cachedProducts.map((e) => Product.fromJson(e)).toList());
    }
    // Start listening to the product stream
    loadfavourites();
  }

  void loadfavourites() async {
    var data = await favouritesService.fetchFavorites();
    storage.write('favourites', data);
    print("2314324$favourites");
    ;
  }

  void addToFavourite(Product product) {
    favourites.add(product);
    favouritesService.addFavorite(product.productId);
  }

  void removeFromFavourite(Product product) async {
    favourites.remove(product);
    await favouritesService.removeFavorite(product.productId);
  }
}
