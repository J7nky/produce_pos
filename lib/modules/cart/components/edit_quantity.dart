import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/data/models/cart_model.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';

class EditQuantity extends StatelessWidget {
  const EditQuantity({
    super.key,
    required this.cartItem,
  });

  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: AppDefaults.padding),
      child: SizedBox(
        height: 30.spMax,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      cartController.removeItem(cartItem);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: AppDefaults.padding / 4),
                      child: Container(
                        height: 25.spMax,
                        width: 25.spMax,
                        decoration: const BoxDecoration(
                            color: AppColors.primary, shape: BoxShape.circle),
                        child: Icon(
                          size: 20.spMax,
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Text(
                  "${cartItem.quantity}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(45.r)),
                  onTap: () async {
                    cartController.addItem(cartItem);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: AppDefaults.padding / 4),
                    child: Container(
                        height: 25.spMax,
                        width: 25.spMax,
                        decoration: const BoxDecoration(
                            color: AppColors.primary, shape: BoxShape.circle),
                        child: Icon(
                          size: 20.spMax,
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text("(${cartItem.quantity})",
                      style: Theme.of(context).textTheme.labelLarge),
                ),
                Center(
                  child: Text(
                    "LBP ${cartItem.product.price * cartItem.quantity}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
