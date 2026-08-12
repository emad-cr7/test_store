import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/provider/provider_controller.dart';
import 'favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer2<ProviderController, FavoriteController>(
        builder: (context, controller, favoriteController, _) {
          if (controller.allProducts.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue,
                size: 55,
              ),
            );
          }

          final favoriteProducts = favoriteController.favoriteProducts;

          if (favoriteProducts.isEmpty) {
            return CustomNoProduct(
              refetch: () {},
              title: 'No favorite products found.',
              icon: Icons.favorite,
            );
          }

          return CustomScrollView(
            slivers: [
              CustomProduct(
                products: favoriteProducts,
                itemCount: favoriteProducts.length,
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 105),
              ),
            ],
          );
        },
      ),
    );
  }
}