import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/title_and_action_button.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/modules/home/components/home_product_card.dart';
import 'package:produce_pos/modules/home/controller/categories_controller.dart';

import '../controller/products_controller.dart';

class HomeProductSection extends StatefulWidget {
  const HomeProductSection({super.key});

  @override
  State<HomeProductSection> createState() => _HomeProductSectionState();
}

class _HomeProductSectionState extends State<HomeProductSection> {
  final productsController = Get.put(ProductsController());
  final categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    var data = categoriesController.categories
        .where((category) => (category.comingSoon == false))
        .toList();
    return ListView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // Prevents conflicting scroll behavior
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var category = data[index];
          return Column(
            children: [
              TitleAndActionButton(
                title: category.categoryName,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.popularItems),
              ),
              Obx(() {
                var data = productsController.products
                    .where((product) =>
                        (product.productCategoryId == category.categoryId) &&
                        (product.productAvailable == true))
                    .take(10)
                    .toList();
                data.sort(
                    (a, b) => b.popularityScore.compareTo(a.popularityScore));

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(left: AppDefaults.padding),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(data.length, (index) {
                      final product = data[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: AppDefaults.padding),
                        child: HomeProduct(product: product),
                      );
                    }),
                  ),
                );
              })
            ],
          );
        });
  }
}
