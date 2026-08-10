import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomProductSkeleton extends StatelessWidget {
  const CustomProductSkeleton({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 300,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey,
                    ),

                    Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                        onPressed: null,
                        icon: const Icon(Icons.favorite_border, size: 25),
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
                    const Text(
                      'Product title example',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '\$99.99',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        IconButton(
                          onPressed: null,
                          icon: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ],
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
