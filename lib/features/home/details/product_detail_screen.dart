import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/provider/provider_controller.dart';
import 'package:readmore/readmore.dart';
import '../model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

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
                          CachedNetworkImage(
                            imageUrl: product.images[0],
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              height: 350,
                              child: const Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: Consumer<ProviderController>(
                              builder:
                                  (
                                    BuildContext context,
                                    ProviderController controller,
                                    Widget? child,
                                  ) {
                                    return IconButton(
                                      onPressed: () {
                                        controller.toggleFavorite(product);
                                      },
                                      icon:
                                          Icon(
                                                product.isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: product.isFavorite
                                                    ? Colors.red
                                                    : Colors.white,
                                              )
                                              .animate(
                                                target: product.isFavorite
                                                    ? 1
                                                    : 0,
                                              )
                                              .scale(
                                                begin: const Offset(1, 1),
                                                end: const Offset(1.3, 1.3),
                                                duration: 250.ms,
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
