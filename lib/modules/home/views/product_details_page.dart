import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produce_pos/data/models/cart_model.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/data/services/favourite_service.dart';
import 'package:produce_pos/modules/cart/components/edit_quantity.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/components/buy_now_row_button.dart';
import '../../../core/components/price_and_quantity.dart';
import '../../../core/components/product_images_slider.dart';
import '../../../core/components/review_row_button.dart';
import '../../../core/constants/app_defaults.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    FavoriteService favoriteService = FavoriteService();
    final Product product = Get.arguments;
    print(product.color);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Product Details'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: BuyNowRow(
            onBuyButtonTap: () {
              cartController.addItem(CartModel(product, 1));
            },
            product: product,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImagesSlider(
              images: [product.carouselImages],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: PriceAndQuantityRow(
                currentPrice: product.price,
                // orginalPrice: 30,
                quantity: 1,
              ),
            ),
            const SizedBox(height: 8),

            /// Product Details
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Description',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(product.description),
                ],
              ),
            ),

            /// Review Row
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                // vertical: AppDefaults.padding,
              ),
              child: Column(
                children: [
                  Divider(thickness: 0.1),
                  ReviewRowButton(totalStars: 5),
                  Divider(thickness: 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
