import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/utils/price_generator.dart';
import 'package:produce_pos/data/models/product_model.dart';

import '../constants/constants.dart';
import '../routes/app_routes.dart';
import 'network_image.dart';

class BundleTileSquare extends StatefulWidget {
  const BundleTileSquare({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<BundleTileSquare> createState() => _BundleTileSquareState();
}

class _BundleTileSquareState extends State<BundleTileSquare> {
  double fakePrice = 0;
  Future<void> getFakePriceAsync(Product product) async {
    double price = await PriceGenerator.getFakePrice(product);
    setState(() {
      fakePrice = price;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getFakePriceAsync(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.productDetails, arguments: widget.product);
        },
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          width: 176,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: AppColors.placeholder),
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    widget.product.carouselImages,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${widget.product.price}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '\$${fakePrice}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
