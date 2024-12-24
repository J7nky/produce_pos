// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:produce_pos/data/models/product_model.dart';


// class ProductScreen extends StatefulWidget {
//   final Product product;
//   const ProductScreen({super.key, required this.product});

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// PanelController slidingUpController = PanelController();
// TextEditingController _collectionController = TextEditingController();
// int carouselImageIndex = 0;
// bool _isLoading = false;
// bool _panelOpen = false;

// class _ProductScreenState extends State<ProductScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _panelOpen = false;
//     _controller.dispose();
//     super.dispose();
//   }

//   final TextEditingController _controller = TextEditingController();
//   String _favouriteReference = '';
//   @override
//   Widget build(BuildContext context) {
//     if (signinState == ApplicatoionLoginState.signedIn) {
//       _favouriteReference = '/users-cart-items/${user!.phoneNumber}/items';
//     }
//     ScrollController scrollController = ScrollController();
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: primaryColor,
//         body: Column(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 child: Stack(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     children: [
//                       Positioned(
//                           left: 30.w,
//                           top: 30.h,
//                           right: 40.w,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               GestureDetector(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: back_Button()),
//                               Text(
//                                 "Details",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 55.sp,
//                                     color: Colors.black),
//                               ),
//                               (signinState == ApplicatoionLoginState.signedIn)
//                                   ? StreamBuilder<Object>(
//                                       stream: FirebaseFirestore.instance
//                                           .collection("users-cart-items")
//                                           .doc(user!.phoneNumber)
//                                           .collection("items")
//                                           .snapshots(),
//                                       builder:
//                                           (context, AsyncSnapshot snapshot) {
//                                         if (snapshot.hasData &&
//                                             !snapshot.hasError) {
//                                           var data = snapshot.data.docs;
//                                           return IconButton(
//                                             onPressed: () => Navigator
//                                                 .pushNamedAndRemoveUntil(
//                                                     context,
//                                                     '/cart',
//                                                     (route) => true),
//                                             icon: badges.Badge(
//                                               position:
//                                                   badges.BadgePosition.topEnd(
//                                                       top: -17, end: -10),
//                                               showBadge: data.length == 0
//                                                   ? false
//                                                   : true,
//                                               badgeStyle:
//                                                   const badges.BadgeStyle(
//                                                       badgeColor:
//                                                           secondaryColor),
//                                               badgeContent: Text(
//                                                 data.length <= 9
//                                                     ? data.length.toString()
//                                                     : "+9",
//                                                 style: TextStyle(
//                                                     fontSize: 35.sp,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                               child: Icon(
//                                                 Icons.shopping_cart_outlined,
//                                                 size: 80.sp,
//                                               ),
//                                             ),
//                                           );
//                                         } else {
//                                           return emptyPlaceHolder;
//                                         }
//                                       })
//                                   : emptyPlaceHolder
//                             ],
//                           )),
//                       Positioned(
//                           bottom: 30.h,
//                           right: 30.w,
//                           child: Container(
//                             height: 50.h,
//                             width: 110.w,
//                             decoration: BoxDecoration(
//                                 // boxShadow: [
//                                 //   BoxShadow(
//                                 //       color:
//                                 //           Colors.transparent.withOpacity(0.05),
//                                 //       offset: const Offset(1, 1),
//                                 //       blurRadius: 2),
//                                 //   BoxShadow(
//                                 //       color:
//                                 //           Colors.transparent.withOpacity(0.05),
//                                 //       offset: const Offset(-1, -1),
//                                 //       blurRadius: 2)
//                                 // ],
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(50.r),
//                                 ),
//                                 color: Colors.transparent.withOpacity(0.05)),
//                             child: Center(
//                               child: Text(
//                                 "${carouselImageIndex + 1} / ${widget.product.carousel_images.length}",
//                                 style: TextStyle(
//                                     fontSize: 30.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           )),
//                       CarouselSlider.builder(
//                           itemCount: widget.product.carousel_images.length,
//                           itemBuilder: (context, index, realIndex) {
//                             // Future.delayed(Duration(milliseconds: 300), () {
//                             //   setState(() {
//                             //     carouselImageIndex = index;
//                             //   });
//                             // }).onError((error, stackTrace) => null);

//                             return CachedNetworkImage(
//                                 fit: BoxFit.fill,
//                                 imageUrl:
//                                     widget.product.carousel_images[index]);
//                           },
//                           options: CarouselOptions(
//                               aspectRatio: 12 / 9,
//                               viewportFraction: 1,
//                               autoPlay:
//                                   widget.product.carousel_images.length == 1
//                                       ? false
//                                       : true)),
//                     ]),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Stack(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(90.r),
//                           topRight: Radius.circular(90.r),
//                           bottomRight: Radius.circular(120.r),
//                         )),
//                     child: SlidingUpPanel(
//                       defaultPanelState: PanelState.CLOSED,
//                       onPanelClosed: () {
//                         setState(() {
//                           _panelOpen = false;
//                         });
//                       },
//                       minHeight: 0,
//                       padding: const EdgeInsets.only(
//                           left: defualtPadding, right: defualtPadding),
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(90.r)),
//                       controller: slidingUpController,
//                       panel: Padding(
//                           padding: EdgeInsets.only(
//                               top: 100.sp, right: 20.sp, bottom: 550.sp),
//                           child: (signinState ==
//                                   ApplicatoionLoginState.signedIn)
//                               ? StreamBuilder<Object>(
//                                   stream: FirebaseFirestore.instance
//                                       .collection(
//                                           '/user-collection/${user!.phoneNumber}/collections')
//                                       .snapshots(),
//                                   builder: (context, AsyncSnapshot snapshot) {
//                                     if (snapshot.hasData &&
//                                         !snapshot.hasError) {
//                                       var data = snapshot.data.docs;
//                                       if (data.length == 0) {
//                                         return Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               'No collections',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge,
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                   'There are no collections, add one',
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyMedium,
//                                                   textAlign: TextAlign.center),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: defualtPadding * 2),
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: InkWell(
//                                                   onTap: () =>
//                                                       addCollectionDialog(
//                                                           context, _controller),
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               70.r),
//                                                       // boxShadow: [
//                                                       //   BoxShadow(
//                                                       //       spreadRadius: 2,
//                                                       //       color: secondaryColor
//                                                       //           .withOpacity(
//                                                       //               0.3)),
//                                                       // ]
//                                                     ),
//                                                     child: CircleAvatar(
//                                                       radius: 70.r,
//                                                       backgroundColor:
//                                                           secondaryColor,
//                                                       child: Icon(
//                                                         Icons.add_sharp,
//                                                         size: 80.sp,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       }
//                                       return collectionsWidget(
//                                           data: data,
//                                           product: widget.product,
//                                           controller: _controller);
//                                     } else {
//                                       return emptyPlaceHolder;
//                                     }
//                                   })
//                               : emptyPlaceHolder),
//                       body: Padding(
//                         padding: EdgeInsets.only(
//                             left: 50.w,
//                             bottom: MediaQuery.of(context).size.height * 0.5),
//                         child: ListView(
//                             physics: const BouncingScrollPhysics(),
//                             controller: scrollController,
//                             children: [
//                               SizedBox(
//                                 height: 70.h,
//                               ),
//                               Text(
//                                 widget.product.name,
//                                 style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 70.sp,
//                                         color: Colors.black)),
//                               ),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     '${widget.product.price}LBP ',
//                                     style: TextStyle(
//                                         color: secondaryColor,
//                                         fontSize: 65.sp,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Text(
//                                     '/ ${widget.product.weight}',
//                                     style:
//                                         Theme.of(context).textTheme.bodyMedium,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               Text(
//                                 "Description:",
//                                 style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 55.sp,
//                                 )),
//                               ),
//                               Text(
//                                 widget.product.description,
//                                 style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 43.sp,
//                                         color: Colors.black38)),
//                               ),
//                               SizedBox(
//                                 height: 400.h,
//                               )
//                             ]),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     child: Padding(
//                         padding: const EdgeInsets.all(defualtPadding),
//                         child: dragHandle()),
//                   ),
//                   (signinState == ApplicatoionLoginState.signedIn)
//                       ? Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(defualtPadding),
//                             child: Center(
//                                 child: !_panelOpen
//                                     ? OutlinedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             _panelOpen = true;
//                                             slidingUpController.open();
//                                           });
//                                         },
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'Add to collection',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displaySmall,
//                                             ),
//                                             const Icon(
//                                               Icons.bookmark_outline_rounded,
//                                               color: Colors.black,
//                                             ),
//                                           ],
//                                         ))
//                                     : IconButton(
//                                         onPressed: () async {
//                                           setState(() {
//                                             _panelOpen = false;

//                                             slidingUpController.close();
//                                           });
//                                         },
//                                         icon: const Icon(Icons.close))),
//                           ),
//                         )
//                       : emptyPlaceHolder,
//                   Positioned(
//                       child: CustomPaint(
//                     size: Size(MediaQuery.of(context).size.width,
//                         (400.h)), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//                     painter: RPSCustomPainter(),
//                   )),
//                   Positioned(
//                       bottom: 40.h,
//                       right: 30.w,
//                       left: 30.w,
//                       child: widget.product.available
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 (signinState == ApplicatoionLoginState.signedIn)
//                                     ? Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 30.w),
//                                         child: StreamBuilder<Object>(
//                                             stream: FirebaseFirestore.instance
//                                                 .collection(
//                                                     '/users-favourite-items/${user!.phoneNumber}/items')
//                                                 .where("id",
//                                                     isEqualTo:
//                                                         widget.product.id)
//                                                 .snapshots(),
//                                             builder: (context,
//                                                 AsyncSnapshot snapshot) {
//                                               if (snapshot.data == null ||
//                                                   snapshot.hasError) {
//                                                 return const Text("");
//                                               }
//                                               return InkWell(
//                                                 child: Container(
//                                                   width: 110.w,
//                                                   height: 110.h,
//                                                   decoration: BoxDecoration(
//                                                       // boxShadow: [
//                                                       //   BoxShadow(
//                                                       //       color: Colors
//                                                       //           .transparent
//                                                       //           .withOpacity(
//                                                       //               0.3),
//                                                       //       offset:
//                                                       //           const Offset(
//                                                       //               1, 1),
//                                                       //       blurRadius: 2),
//                                                       //   BoxShadow(
//                                                       //       color: Colors
//                                                       //           .transparent
//                                                       //           .withOpacity(
//                                                       //               0.3),
//                                                       //       offset:
//                                                       //           const Offset(
//                                                       //               -1, -1),
//                                                       //       blurRadius: 2)
//                                                       // ],
//                                                       color: primaryColorLight,
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   20.r))),
//                                                   child: snapshot.data.docs
//                                                               .length ==
//                                                           0
//                                                       ? Icon(
//                                                           Icons
//                                                               .favorite_outline,
//                                                           size: 70.sp,
//                                                           color: Colors
//                                                               .red.shade600,
//                                                         )
//                                                       : Icon(
//                                                           Icons.favorite,
//                                                           color: Colors.red,
//                                                           size: 75.sp,
//                                                         ),
//                                                 ),
//                                                 onTap: () {
//                                                   snapshot.data.docs.length == 0
//                                                       ? FirestoreUtil
//                                                           .addToFavouirte(
//                                                               widget.product)
//                                                       : FirestoreUtil
//                                                           .removeFromFavourite(
//                                                               widget
//                                                                   .product.id);
//                                                 },
//                                               );
//                                             }),
//                                       )
//                                     : InkWell(
//                                         onTap: () {
//                                           notRegistered(context);
//                                         },
//                                         child: Container(
//                                             width: 110.w,
//                                             height: 110.h,
//                                             decoration: BoxDecoration(
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Colors.transparent
//                                                           .withOpacity(0.3),
//                                                       offset:
//                                                           const Offset(1, 1),
//                                                       blurRadius: 2),
//                                                   BoxShadow(
//                                                     color: Colors.transparent
//                                                         .withOpacity(0.3),
//                                                   )
//                                                 ],
//                                                 color: primaryColorLight,
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(20.r))),
//                                             child: Icon(
//                                               Icons.favorite_outline,
//                                               size: 60.sp,
//                                             )),
//                                       ),
//                                 (signinState == ApplicatoionLoginState.signedIn)
//                                     ? StreamBuilder<Object>(
//                                         stream: FirebaseFirestore.instance
//                                             .collection(
//                                                 '/users-cart-items/${user!.phoneNumber}/items')
//                                             .where("id",
//                                                 isEqualTo: widget.product.id)
//                                             .snapshots(),
//                                         builder:
//                                             (context, AsyncSnapshot snapshot) {
//                                           if (snapshot.data == null ||
//                                               snapshot.hasError) {
//                                             return const Text("");
//                                           } else {
//                                             var data = snapshot.data.docs;
//                                             return Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 20.w),
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.7,

//                                               child: _isLoading
//                                                   ? CircularProgressIndicator(
//                                                       strokeWidth: 15.w,
//                                                       color: Colors.white,
//                                                     )
//                                                   : data.length == 0
//                                                       ? highLightedButton(
//                                                           text: '+Add To Cart',
//                                                           onPressed: () async {
//                                                             _isLoading = true;
//                                                             if (signinState ==
//                                                                 ApplicatoionLoginState
//                                                                     .signedIn) {
//                                                               await FirestoreUtil.addToCart(
//                                                                       CartItem.fromJson(widget
//                                                                           .product
//                                                                           .toJson()))
//                                                                   .then(
//                                                                       (value) {
//                                                                 _isLoading =
//                                                                     false;
//                                                               });
//                                                             } else {
//                                                               notRegistered(
//                                                                   context);
//                                                               _isLoading =
//                                                                   false;
//                                                             }
//                                                           },
//                                                         )
//                                                       : Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   vertical:
//                                                                       11.5),
//                                                           child:
//                                                               add_remove_product(
//                                                             data: data,
//                                                             product:
//                                                                 widget.product,
//                                                           ),
//                                                         ),
//                                               // Row(
//                                               //   children: [
//                                               //     TextButton(
//                                               //         onPressed: () async {
//                                               //           await FirestoreUtil
//                                               //               .productIncreament(
//                                               //                   CartItem.fromJson(widget
//                                               //                       .product
//                                               //                       .toJson()));
//                                               //           if (data[0]['quantity'] < 1) {
//                                               //             await FirestoreUtil
//                                               //                 .removeFromCart(
//                                               //                     widget.product);
//                                               //           }
//                                               //         },
//                                               //         child: Text(
//                                               //           '+',
//                                               //           style: extraLargeText,
//                                               //         )),
//                                               //     TextButton(
//                                               //         onPressed: ()
//                                               //         child: Text(
//                                               //           '-',
//                                               //           style: extraLargeText,
//                                               //         )),
//                                               //   ],
//                                               // )
//                                             );
//                                           }
//                                         })
//                                     : Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 20.w),
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.7,
//                                         child: highLightedButton(
//                                             text: '+Add To Cart',
//                                             onPressed: () {
//                                               notRegistered(context);
//                                             }))
//                               ],
//                             )
//                           : Padding(
//                               padding: const EdgeInsets.all(defualtPadding),
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Out Of Stock",
//                                   style: TextStyle(
//                                       fontSize: 60.sp,
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold,
//                                       fontStyle: FontStyle.italic),
//                                 ),
//                               ),
//                             )),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class add_remove_product extends StatelessWidget {
//   add_remove_product({super.key, required this.data, required this.product});

//   var data;
//   Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//             right: defualtPadding,
//           ),
//           child: InkWell(
//               onTap: () async {
//                 _isLoading = true;
//                 if (data[0]['quantity'] > 1) {
//                   await FirestoreUtil.productDecreament(
//                       CartItem.fromJson(product.toJson()));
//                   _isLoading = false;
//                 } else {
//                   await FirestoreUtil.removeFromCart(
//                           CartItem.fromJson(product.toJson()))
//                       .then((value) => _isLoading = false);
//                 }
//               },
//               child: CircleAvatar(
//                 backgroundColor: primaryColorLight,
//                 radius: 34.r,
//                 child: Center(
//                     child: Icon(
//                   Icons.remove,
//                   size: 40.sp,
//                   color: Colors.white,
//                 )),
//               )),
//         ),
//         Text(
//           "${data[0]['quantity']}",
//           style: Theme.of(context).textTheme.displayMedium,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//               right: defualtPadding, left: defualtPadding),
//           child: InkWell(
//               onTap: () async {
//                 _isLoading = false;
//                 if (data[0]['quantity'] < 99 && data[0]['quantity'] > 0) {
//                   await FirestoreUtil.productIncreament(
//                       CartItem.fromJson(product.toJson()));
//                   _isLoading = false;
//                 } else {
//                   () {
//                     _isLoading = false;
//                   };
//                 }
//               },
//               child: Container(
//                 child: CircleAvatar(
//                   backgroundColor: primaryColorLight,
//                   radius: 34.r,
//                   child: Center(
//                       child: Icon(
//                     Icons.add,
//                     size: 40.sp,
//                     color: Colors.white,
//                   )),
//                 ),
//               )),
//         ),
//         Text("Quantity: ${data[0]['quantity']}(${data[0]["weight"]})",
//             style: GoogleFonts.poppins(
//                 fontSize: 35.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black38))
//       ],
//     );
//   }
// }
