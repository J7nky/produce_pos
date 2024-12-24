import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/constants/constants.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/modules/home/controller/favorites_controller.dart';
import 'package:produce_pos/modules/home/views/product_details_page.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({
    super.key,
  });

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

final favoritesController = Get.put(FavoritesController());

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    int length = 1;
    return Padding(
        padding: EdgeInsets.only(
          left: 30.w,
        ),
        child: Obx(() {
          var data = favoritesController.favourites;
          if (data.isEmpty) {
            return Container();
          }
          return Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding / 2),
                  child: Text(
                    'Favourite Products❤️',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Favourites()));
                    // Navigate.pushTo(context,
                    //     AllTrendingsPage(trendings: trendings, title: title));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: AppDefaults.padding / 2),
                    child: Text(
                      'Show All',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 700.h,
                child: Row(children: [
                  Expanded(
                      child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.productDetails,
                            arguments: data[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
                        width: 400.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(4293525470),
                          // Color(4293525470),
                          borderRadius: BorderRadius.circular(40.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 231, 230, 230),
                              offset: Offset(-1, -1),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(255, 231, 230, 230),
                              offset: Offset(1, 1),
                            )
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: "${data[index].carouselImages}",
                          width: 300.w,
                          height: 300.h,
                          fit: BoxFit.contain,
                          placeholder: (context, url) {
                            return Center(child: CircularProgressIndicator());
                          },
                          errorWidget: (context, url, error) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  ))
                ]))
          ]);
        }));
  }
}
