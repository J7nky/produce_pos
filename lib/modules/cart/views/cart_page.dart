import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/modules/cart/components/cart_items.dart';
import 'package:produce_pos/modules/cart/components/cart_panel.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/components/app_back_button.dart';
import '../../../core/constants/app_defaults.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.getCartFromPreferences();
    return Scaffold(
      appBar: widget.isHomePage
          ? null
          : AppBar(
              leading: const AppBackButton(),
              title: const Text('Cart Page'),
            ),
      body: SlidingUpPanel(
        padding: const EdgeInsets.only(
            left: AppDefaults.padding, right: AppDefaults.padding),
        borderRadius: BorderRadius.vertical(top: Radius.circular(90.r)),
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        minHeight: 100.spMax,
        snapPoint: 0.75,
        backdropEnabled: true,
        parallaxEnabled: true, body: CartItems(),
        panelBuilder: (sc) {
          return CartPanel(
              scrollController: sc, bigTotal: cartController.getTotal());
        },
        // children: [
        //   CartItems(),

        // SizedBox(
        //   height: 500,
        //   child: Obx(() {
        //     if (cartController.cartItems.isEmpty) {
        //       return Center(child: Text('Your cart is empty.'));
        //     }
        //     return ListView.builder(
        //       itemCount: cartController.cartItems.length,
        //       itemBuilder: (context, index) {
        //         final item = cartController.cartItems[index];
        //         return ListTile(
        //           title: Text(item.product.productName),
        //           subtitle: Text('Quantity: ${item.quantity}'),
        //           trailing: Text(
        //               '\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
        //           onLongPress: () {},
        //         );
        //       },
        //     );
        //   }),
        // ),
        // const SingleCartItemTile(),
        // const SingleCartItemTile(),
        // const SingleCartItemTile(),
        // const CouponCodeField(),
        // const ItemTotalsAndPrice(),
        // SizedBox(
        //   width: double.infinity,
        //   child: Padding(
        //     padding: const EdgeInsets.all(AppDefaults.padding),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         // Navigator.pushNamed(context, AppRoutes.orderSuccessfull);
        //         Navigator.pushNamed(context, AppRoutes.checkoutPage);
        //       },
        //       child: const Text('Checkout'),
        //     ),
        //   ),
        // ),
        // ],
      ),
      // floatingActionButton: ElevatedButton(
      //   child: Icon(Icons.delete),
      //   onPressed: () {
      //     cartController.clearCart();
      //   },
      // ),
    );
  }
}
