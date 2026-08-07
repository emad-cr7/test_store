import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/provider/provider_controller.dart';
import 'package:readmore/readmore.dart';

import '../model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  // بديل الـ setState: ValueNotifier بيتابع الصورة الحالية بس
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final hasImage = product.images.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: hasImage
                    ? Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 350,
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
                                        size: 30,
                                      ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          Positioned(
                            top: 1,
                            right: 1,
                            child: Consumer<ProviderController>(
                              builder: (context, controller, _) {
                                return IconButton(
                                  onPressed: () =>
                                      controller.toggleFavorite(product),
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
                              bottom: 10,
                              left: 0,
                              right: 0,
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
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          width: isSelected ? 20 : 8,
                                          height: 8,
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
                        height: 350,
                        width: double.infinity,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
              ),

              const SizedBox(height: 20),

              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              const Center(child: SizedBox(width: 300, child: Divider())),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ReadMoreText(
                product.description.isNotEmpty
                    ? product.description
                    : 'No description available.',
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                style: const TextStyle(fontSize: 16, height: 1.5),
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
