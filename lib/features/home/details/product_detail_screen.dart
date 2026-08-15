import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/favorite/favorite_controller.dart';
import 'package:readmore/readmore.dart';

import '../models/product_model.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theming/app_sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final hasImage = product.images.isNotEmpty;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.productDetails)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.r16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r12),
                child: hasImage
                    ? Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: AppSizes.h350,
                              viewportFraction: 1,
                              autoPlay: product.images.length > 1,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                _currentPage.value = index;
                              },
                            ),
                            items: product.images.map((url) {
                              return CachedNetworkImage(
                                imageUrl: url,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
                                        color: Colors.blue,
                                        size: AppSizes.sp30,
                                      ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.broken_image,
                                    size: AppSizes.sp80,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          Positioned(
                            top: AppSizes.h1,
                            right: AppSizes.w1,
                            child: Consumer<FavoriteController>(
                              builder: (context, favoriteController, _) {
                                return IconButton(
                                  onPressed: () =>
                                      favoriteController.toggleFavorite(product),
                                  icon: Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: product.isFavorite
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          if (product.images.length > 1)
                            Positioned(
                              bottom: AppSizes.h10,
                              left: AppSizes.w0,
                              right: AppSizes.w0,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _currentPage,
                                builder: (context, currentIndex, _) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      product.images.length,
                                      (index) {
                                        final isSelected =
                                            index == currentIndex;
                                        return AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: AppSizes.w4,
                                          ),
                                          width: isSelected ? 20 : 8,
                                          height: AppSizes.h8,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white54,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      )
                    : Container(
                        color: Colors.grey[300],
                        height: AppSizes.h350,
                        width: double.infinity,
                        child: Icon(
                          Icons.image_not_supported,
                          size: AppSizes.sp80,
                          color: Colors.grey,
                        ),
                      ),
              ),

              SizedBox(height: AppSizes.ph20),

              Text(
                product.title,
                style: TextStyle(
                  fontSize: AppSizes.sp24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: AppSizes.h8),
              Center(child: SizedBox(width: AppSizes.w300, child: Divider())),
              SizedBox(height: AppSizes.h8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.description,
                    style: TextStyle(fontSize: AppSizes.sp18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: AppSizes.sp22,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.h8),

              ReadMoreText(
                product.description.isNotEmpty
                    ? product.description
                    : t.noDescriptionAvailable,
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: t.showMore,
                trimExpandedText: t.showLess,
                style: TextStyle(fontSize: AppSizes.sp16, height: AppSizes.h1_5),
                moreStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                lessStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
