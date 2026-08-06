import 'package:flutter/material.dart';

import '../../core/Preferences_manager/preferences_manager.dart';
import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
import '../home/model/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<List<ProductModel>> getFavoriteProducts(List<ProductModel> products) async {
    for (var product in products) {
      product.isFavorite = await PreferencesManager().getBool("favorite_${product.id}") ?? false;
    }

    return products.where((product) => product.isFavorite).toList();
  }

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
          return FutureBuilder<List<ProductModel>>(
            future:  getFavoriteProducts(products),
            builder: (context, snapshot) {
              final favoriteProducts = snapshot.data ?? [];

              if (favoriteProducts.isEmpty) {
                return CustomNoProduct(
                  refetch: () {},
                  title: 'No favorite products found.', icon: Icons.favorite,
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
