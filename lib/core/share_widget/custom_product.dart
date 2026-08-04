import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../features/home/details/product_detail_screen.dart';
import '../../features/home/model/product_model.dart';
import '../Preferences_manager/preferences_manager.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({
    super.key,
    required this.products,
    required this.itemCount,
  });

  final List<ProductModel> products;
  final int itemCount;

  @override
  State<CustomProduct> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 300,
      ),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        final product = widget.products[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Stack(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                borderOnForeground: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: product.images[0],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  product.isFavorite = !product.isFavorite;
                                });
                                await PreferencesManager().setBool(
                                  "favorite_${product.id}",
                                  product.isFavorite,
                                );
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
                                        target: product.isFavorite ? 1 : 0,
                                      )
                                      .scale(
                                        begin: const Offset(1, 1),
                                        end: const Offset(1.3, 1.3),
                                        duration: 250.ms,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.lightGreen.shade700,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    product.shoppingCart =
                                        !product.shoppingCart;
                                  });
                                },
                                icon: Icon(
                                  product.shoppingCart
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: product.shoppingCart
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
