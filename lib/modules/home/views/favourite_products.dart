// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


// class FavouriteList extends StatefulWidget {
//   final String dataPath;
//   final String title;

//   const FavouriteList({
//     super.key,
//     required this.dataPath,
//     required this.title,
//   });

//   @override
//   State<FavouriteList> createState() => _FavouriteListState();
// }

// class _FavouriteListState extends State<FavouriteList> {
//   @override
//   Widget build(BuildContext context) {
//     int length = 1;
//     return Padding(
//         padding: EdgeInsets.only(
//           left: 30.w,
//         ),
//         child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection(widget.dataPath)
//                 .snapshots(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData && !snapshot.hasError) {
//                 var data = snapshot.data.docs;
//                 if (data.length == 0) {
//                   return SizedBox(
//                     height: 0.h,
//                   );
//                 }
//                 return Column(children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(defualtPadding / 2),
//                         child: SectionTitle(context, widget.title),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Favourites()));
//                           // Navigate.pushTo(context,
//                           //     AllTrendingsPage(trendings: trendings, title: title));
//                         },
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(right: defualtPadding / 2),
//                           child: Text(
//                             'Show All',
//                             style: TextStyle(
//                                 color: secondaryColor,
//                                 fontSize: 45.sp,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                       height: 700.h,
//                       child: Row(children: [
//                         Expanded(
//                             child: ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: data?.length,
//                           itemBuilder: (context, index) => GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ProductScreen(
//                                             product: Product.fromJson(
//                                                 data[index].data(),
//                                                 data[index].id,
//                                                 widget.title),
//                                           )));
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   top: 10.h,
//                                   bottom: 10.h,
//                                   left: 15.w,
//                                   right: 15.w),
//                               width: 400.w,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: secondaryColor.withOpacity(0.7),
//                                 // Color(4293525470),
//                                 borderRadius: BorderRadius.circular(40.r),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color.fromARGB(255, 231, 230, 230),
//                                     offset: Offset(-1, -1),
//                                   ),
//                                   BoxShadow(
//                                     color: Color.fromARGB(255, 231, 230, 230),
//                                     offset: Offset(1, 1),
//                                   )
//                                 ],
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl: "${data[index]["image"]}",
//                                 width: 300.w,
//                                 height: 300.h,
//                                 fit: BoxFit.contain,
//                                 placeholder: (context, url) {
//                                   return Center(child: defaultLoading());
//                                 },
//                                 errorWidget: (context, url, error) {
//                                   return Center(child: defaultLoading());
//                                 },
//                               ),
//                             ),
//                           ),
//                         ))
//                       ]))
//                 ]);
//               } else {
//                 return emptyPlaceHolder;
//               }
//             }));
//   }
// }
