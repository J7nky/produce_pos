import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/data/models/cart_model.dart';
import 'package:produce_pos/modules/cart/components/edit_quantity.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    cartController.getCartFromPreferences();
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: EdgeInsets.only(
                  top: AppDefaults.padding / 2,
                  bottom: MediaQuery.of(context).size.height * 0.3),
              child: Obx(
                () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (_, index) {
                      var data = cartController.cartItems;
                      // int total = data[index]["quantity"] * data[index]['price'];

                      return Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding / 2),
                        child: GestureDetector(
                          onTap: () {
                            // searchItem(data[index]['id']);

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ProductScreen(
                            //               product: _result,
                            //             )));
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsOverflowButtonSpacing: 0,
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      title: Text('Delete Item',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      content: Text(
                                        "Are you sure you want to delete the item?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: AppDefaults.padding),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 80.spMax,
                                          height: 40.spMax,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              'Delete',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            behavior: HitTestBehavior.translucent,
                            onDismissed: (direction) {},
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.r),
                                  )),
                              padding: const EdgeInsets.only(
                                  right: AppDefaults.padding * 4),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30.spMax,
                                ),
                              ),
                            ),
                            key: ValueKey(data[index].product.productId),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: AppDefaults.padding / 2,
                                  right: AppDefaults.padding / 2,
                                  bottom: AppDefaults.padding / 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.r)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Row(children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          AppDefaults.padding),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.r)),
                                      ),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) {
                                          return CircularProgressIndicator();
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container();
                                        },
                                        imageUrl:
                                            data[index].product.carouselImages,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: AppDefaults.padding),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: AppDefaults.padding),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      data[index]
                                                          .product
                                                          .productName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              fontSize: 18)),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: AppDefaults
                                                                  .padding),
                                                      child: Text(
                                                          'LBP ${data[index].product.price}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium))
                                                ],
                                              ),
                                            ),
                                            EditQuantity(cartItem: data[index])
                                          ],
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )),
        ),
      ],
    );
  }
}
