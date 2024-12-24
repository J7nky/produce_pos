import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/modules/home/controller/categories_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CategoriesSection extends StatefulWidget {
  CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final categoriesController = Get.put(CategoriesController());

  ScrollController scrollController = ScrollController();

  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.65);

  int indexStack = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var data = categoriesController.categories;
      if (data.isEmpty) {
        return Container();
      }
      return Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  List<Widget> list = [];
                  for (int i = 0; i < data.length; i++) {
                    list.add(i == indexStack
                        ? categoryName(context, true, data[i].categoryName, i,
                            pageController)
                        : categoryName(context, false, data[i].categoryName, i,
                            pageController));
                  }
                  return list[index];
                }),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  var scale = indexStack == index ? 1.0 : 0.85;
                  return GestureDetector(
                    onTap: () {
                      // controller.jumpToPage(index);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CategoryProdcuts(
                      //                 dataPath:
                      //                     '/products/language/$locale/${data[index]['name']}/items',
                      //                 name: data[index]
                      //                     ['name'])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: AppDefaults.padding,
                          left: AppDefaults.padding),
                      child: TweenAnimationBuilder(
                        curve: Curves.ease,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        tween: Tween(begin: scale, end: scale),
                        duration: const Duration(milliseconds: 350),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  AppColors.coloredBackground.withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.r))),
                          child: CachedNetworkImage(
                            placeholder: (context, url) {
                              return Container();
                            },
                            imageUrl: data[index].categoryImage,
                            errorWidget: ((context, url, error) {
                              return Container();
                            }),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                reverse: false,
                itemCount: data.length,
                onPageChanged: (value) {
                  double position = 0;

                  for (int i = 1; i <= value; i++) {
                    position += (data[i].categoryName.length);
                  }

                  scrollController.animateTo(
                    ((value) * position),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.linearToEaseOut,
                  );
                  setState(() {
                    indexStack = value;
                  });
                },
              ))
        ],
      );
    });
  }
}

Widget categoryName(BuildContext context, bool isActive, String name, int index,
    PageController controller) {
  if (isActive) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 1,
            effect: JumpingDotEffect(
              dotHeight: 15.h,
              dotWidth: 80.w,
              dotColor: Colors.transparent,
              activeDotColor: AppColors.primary,

              // strokeWidth: 5,
            ),
          ),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: GestureDetector(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onTap: () {
          controller.jumpToPage(index);
        },
      ),
    );
  }
}
