import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:produce_pos/data/models/product_model.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/components/bundle_tile_square.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class PopularPackPage extends StatelessWidget {
  const PopularPackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Packs'),
        leading: const AppBackButton(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: AppDefaults.padding),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.73,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return BundleTileSquare(
                    product: Product(
                        productId: 0,
                        productName: " productName",
                        description: "description",
                        price: 12,
                        productTypeId:123,
                        productAvailable: true,
                        currencyId: "123",
                        carouselImages: "carousel_images",
                        color: 123,
                        productCategoryId:0,
                        popularityScore: 0),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(AppDefaults.padding * 2),
                decoration: const BoxDecoration(
                  color: Colors.white60,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.createMyPack);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.shoppingBag),
                      const SizedBox(width: AppDefaults.padding),
                      const Text('Create Own Pack'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
