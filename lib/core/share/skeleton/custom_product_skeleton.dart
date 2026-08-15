import 'package:flutter/material.dart';
import '../../theming/app_sizes.dart';

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
                      top: AppSizes.h1,
                      right: AppSizes.w1,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_border, size: AppSizes.sp25),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(AppSizes.r5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product title example',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: AppSizes.ph4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$99.99',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.sp15,
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
