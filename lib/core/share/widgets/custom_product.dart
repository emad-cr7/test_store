import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../features/home/details/product_detail_screen.dart';
import '../../../features/favorite/favorite_controller.dart';
import '../../../features/cart/cart_controller.dart';
import '../../../features/home/models/product_model.dart';
import '../../l10n/app_localizations.dart';
import 'custom_snackbar.dart';
import '../../theming/app_sizes.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({
    super.key,
    required this.products,
    required this.itemCount,
  });

  final List<ProductModel> products;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 300,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
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
                borderOnForeground: false,
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
                                size: AppSizes.sp20,
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.broken_image,
                                  size: AppSizes.sp50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: AppSizes.h1,
                            right: AppSizes.w1,
                            child: Consumer<FavoriteController>(
                              builder:
                                  (
                                    BuildContext context,
                                    FavoriteController favoriteController,
                                    Widget? child,
                                  ) {
                                    return IconButton(
                                      onPressed: () {
                                        favoriteController.toggleFavorite(product);
                                        AppSnackBar.show(
                                          context,
                                          message: product.isFavorite
                                              ? t.productAddedToFavorites
                                              : t.productRemovedFromFavorites,
                                          icon: product.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          backgroundColor: product.isFavorite
                                              ? Colors.redAccent
                                              : Colors.grey,
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSizes.r5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: AppSizes.ph4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.sp15,
                                  color: Colors.lightGreen.shade700,
                                ),
                              ),
                              Consumer<CartController>(
                                builder:
                                    (
                                      BuildContext context,
                                      CartController cartController,
                                      Widget? child,
                                    ) {
                                      return IconButton(
                                        onPressed: () {
                                          final newValue =
                                              !product.shoppingCart;

                                          cartController.toggleShoppingCart(
                                            product,
                                          );

                                          AppSnackBar.show(
                                            context,
                                            message: newValue
                                                ? t.productAddedToCart
                                                : t.productRemovedFromCart,
                                            icon: newValue
                                                ? Icons.shopping_cart
                                                : Icons.remove_shopping_cart,
                                            backgroundColor: newValue
                                                ? Colors.green
                                                : Colors.grey,
                                          );
                                        },
                                        icon: Icon(
                                          product.shoppingCart
                                              ? Icons.shopping_cart
                                              : Icons.shopping_cart_outlined,
                                          color: product.shoppingCart
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                      );
                                    },
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
