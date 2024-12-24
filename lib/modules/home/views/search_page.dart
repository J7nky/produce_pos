import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/high_lighted_button.dart';
import 'package:produce_pos/data/models/product_model.dart';
import 'package:produce_pos/modules/home/controller/products_controller.dart';
import 'package:produce_pos/modules/home/controller/search_controller.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/ui_util.dart';
import '../dialogs/product_filters_dialog.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SearchPageHeader(),
            SizedBox(height: 8),
            _RecentSearchList(),
          ],
        ),
      ),
    );
  }
}

final _controller = Get.put(SearchControllerr());

class _RecentSearchList extends StatelessWidget {
  const _RecentSearchList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Obx(() => Text(
                    _controller.filteredProducts.isEmpty
                        ? 'Recent Search'
                        : "Result Items",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  )),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    if (_controller.filteredProducts.isEmpty) {
                      return SearchHistoryTile(
                        term: _controller.recentSearches[index],
                      );
                    } else {
                      return SearchResultTile(
                          product: _controller.filteredProducts[index]);
                    }
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.1,
                  ),
                  itemCount: _controller.filteredProducts.isEmpty
                      ? _controller.recentSearches.length
                      : _controller.filteredProducts.length,
                )),
          )
        ],
      ),
    );
  }
}

TextEditingController searchTextController = TextEditingController();

class _SearchPageHeader extends StatelessWidget {
  const _SearchPageHeader();
  @override
  Widget build(BuildContext context) {
    Timer? _debounceTimer;
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const AppBackButton(),
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              children: [
                /// Search Box
                Form(
                  child: TextFormField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: SvgPicture.asset(
                          AppIcons.search,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      suffix: Padding(
                        padding: EdgeInsets.all(AppDefaults.padding / 2),
                        child: InkWell(
                          onTap: () {
                            searchTextController.text = '';
                            _controller.filteredProducts.clear();
                          },
                          child: Icon(
                            Icons.cancel_sharp,
                            color: AppColors.primary.withOpacity(0.6),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    onChanged: (value) {
                      _debounceTimer?.cancel();
                      _debounceTimer = Timer(const Duration(seconds: 2), () {
                        _controller.queryProducts(value);
                      });
                    },
                    onFieldSubmitted: (v) {
                      _controller.queryProducts(v);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultTile extends StatelessWidget {
  final Product product;
  const SearchResultTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: InkWell(
            onTap: () {},
            child: ListTile(
              enableFeedback: false,
              leading: CachedNetworkImage(
                width: 200.h,
                height: 400.h,
                imageUrl: product.carouselImages,
                fit: BoxFit.fill,
              ),
              title: Text(
                '${product.productName}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
      //                Row(
      //   children: [
      //     Text(
      //       product.productName,
      //       style: Theme.of(context).textTheme.bodyMedium,
      //     ),
      //     const Spacer(),
      //     InkWell(
      //         borderRadius: BorderRadius.circular(100),
      //         onTap: () {

      //         },
      //         child: Padding(
      //           padding: EdgeInsets.all(6.spMax),
      //           child: SvgPicture.asset(AppIcons.searchTileArrow),
      //         )),
      //   ],
      // ),
    );
  }
}

class SearchHistoryTile extends StatelessWidget {
  final String term;
  const SearchHistoryTile({
    super.key,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Text(
            term,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                searchTextController.text = term;
                _controller.queryProducts(term);
              },
              child: Padding(
                padding: EdgeInsets.all(6.spMax),
                child: SvgPicture.asset(AppIcons.searchTileArrow),
              )),
        ],
      ),
    );
  }
}
