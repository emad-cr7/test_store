import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
import '../home/home_controller.dart';
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
      body: CustomQuery(
        builder: (products) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeController>().syncProducts(products);
          });

          return Consumer<HomeController>(
            builder: (context, controller, _) {
              final favoriteProducts = controller.favoriteProducts;

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
                ],
              );
            },
          );
        },
      ),
    );
  }
}