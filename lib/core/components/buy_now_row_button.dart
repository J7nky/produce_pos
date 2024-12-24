import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/data/models/cart_model.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/modules/cart/components/edit_quantity.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';

import '../constants/constants.dart';

class BuyNowRow extends StatelessWidget {
  const BuyNowRow({
    super.key,
    required this.product,
    required this.onBuyButtonTap,
  });

  final Product product;
  final void Function() onBuyButtonTap;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDefaults.padding,
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.cartPage);
            },
            child: SvgPicture.asset(AppIcons.shoppingCart),
          ),
          const SizedBox(width: AppDefaults.padding),
          Obx(() {
            var existingItem = cartController.cartItems.firstWhereOrNull(
              (element) => element.product.productId == product.productId,
            );

            return existingItem == null
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: onBuyButtonTap,
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.all(AppDefaults.padding * 1.2),
                      ),
                      child: const Text('Buy Now'),
                    ),
                  )
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppDefaults.padding,
                            bottom: AppDefaults.padding),
                        child: EditQuantity(cartItem: existingItem),
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
