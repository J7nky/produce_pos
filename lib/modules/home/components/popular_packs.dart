import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/progress_dialog.dart';
import 'package:produce_pos/modules/home/controller/products_controller.dart';

import '../../../core/components/bundle_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class PopularPacks extends StatefulWidget {
  const PopularPacks({
    super.key,
  });

  @override
  State<PopularPacks> createState() => _PopularPacksState();
}

class _PopularPacksState extends State<PopularPacks> {
  final productsController = Get.put(ProductsController());
  @override
  void dispose() {
    // TODO: implement dispose
    productsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Popular Packs',
          onTap: () => Navigator.pushNamed(context, AppRoutes.popularItems),
        ),
        StreamBuilder<Object>(
            stream: productsController.productsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(left: AppDefaults.padding),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      Dummy.bundles.length,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: AppDefaults.padding),
                        child: BundleTileSquare(data: Dummy.bundles[index]),
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularPrgressAlertDialog();
              }
            }),
      ],
    );
  }
}
