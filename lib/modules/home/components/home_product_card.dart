// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';
import 'package:produce_pos/modules/home/controller/favorites_controller.dart';
import 'package:produce_pos/modules/home/controller/products_controller.dart';

class HomeProduct extends StatefulWidget {
  final Product product;
  const HomeProduct({
    super.key,
    required this.product,
  });

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  // var _products = [];
  // getFavouriteProducts() async {
  //   _products = await FirestoreUtil.getFavouriteProducuts();
  // }
  final authController = Get.find<AuthController>();
  final favoriteController = Get.find<FavoritesController>();
  final productsController = Get.put(ProductsController());
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.productDetails, arguments: widget.product);

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             ProductScreen(product: widget.product)));
        },
        // onLongPress: () {
        //   Future.delayed(const Duration(milliseconds: 250));
        //   showModalBottomSheet(
        //     context: context,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(
        //       top: Radius.circular(20.r),
        //     )),
        //     clipBehavior: Clip.antiAliasWithSaveLayer,
        //     transitionAnimationController: AnimationController(
        //         duration: const Duration(milliseconds: 235), vsync: this),
        //     builder: (context) {
        //       return ItemPopupActions(
        //         product: widget.product,
        //       );
        //     },
        //   );
        // },
        borderRadius: BorderRadius.circular(15.r),
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Container(
            alignment: Alignment.center,
            width: 400.w,
            height: 270.spMax,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 231, 230, 230),
                    offset: Offset(0.1, 0.1),
                  )
                ],
                borderRadius: BorderRadius.circular(40.r),
                color: Color(widget.product.color)),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: (authController.status ==
                            AuthenticationStatus.authenticated)
                        ? Obx(() {
                            if (favoriteController.favourites.isNotEmpty) {
                              favoriteController.favourites.forEach(
                                (element) {
                                  if (element.productId ==
                                      widget.product.productId) {
                                    isFavourite = true;
                                  }
                                },
                              );
                            }

                            return !isFavourite
                                ? InkWell(
                                    onTap: () {
                                      favoriteController
                                          .addToFavourite(widget.product);
                                    },
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 70.sp,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      favoriteController
                                          .removeFromFavourite(widget.product);
                                      setState(() {
                                        isFavourite = false;
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 70.sp,
                                    ),
                                  );
                          })
                        : InkWell(
                            child: Icon(
                              Icons.favorite_outline,
                              size: 60.sp,
                            ),
                            onTap: () async {
                              // notRegistered(context);
                            },
                          )),
                Positioned(
                    left: 20.w,
                    bottom: 20.h,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.productName,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 46.sp,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "kg",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 42.sp,
                                  color: Colors.black38)),
                        ),
                        // Container(
                        //   width: widget.product.weight.length > 3 ? 55 : 33,
                        //   height: 25,
                        //   decoration: BoxDecoration(
                        //       color: secondaryColor,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(5))),
                        //   child: Center(
                        //     child: Text(
                        //       widget.product.weight,
                        //       style: GoogleFonts.poppins(
                        //           textStyle: TextStyle(
                        //               fontWeight: FontWeight.w500,
                        //               fontSize: 14.sp,
                        //               color: Colors.white)),
                        //     ),
                        //   ),
                        // ),
                        widget.product.productAvailable
                            ? Text(
                                '${widget.product.price} LBP',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(
                                "Out Of Stock",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              )
                      ],
                    )),
                Positioned(
                  top: 60.h,
                  left: 0,
                  right: 0,
                  child: !widget.product.productAvailable
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey.shade600, BlendMode.modulate),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.carouselImages,
                            width: 300.w,
                            height: 300.h,
                            fit: BoxFit.contain,
                            // placeholder: (context, url) {
                            //   return Center(child: defaultLoading());
                            // },
                            // errorWidget: (context, url, error) {
                            //   return Center(child: defaultLoading());
                            // },
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.product.carouselImages,
                          width: 300.w,
                          height: 300.h,
                          fit: BoxFit.contain,
                          // placeholder: (context, url) {
                          //   return Center(child: defaultLoading());
                          // },
                          // errorWidget: (context, url, error) {
                          //   return Center(child: defaultLoading());
                          // },
                        ),
                ),
                Positioned(
                    bottom: 0.h,
                    right: 0.w,
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              bottomRight: Radius.circular(25.r))),
                      child: Icon(
                        size: 60.sp,
                        Ionicons.cart_outline,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
