import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../details/product_detail_screen.dart';
import '../model/product_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return       InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: product.images[0],
                      fit: BoxFit.cover,
                      width: double.infinity,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        Text('\$${product.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
