import 'package:flutter/material.dart';

import '../../core/Preferences_manager/preferences_manager.dart';
import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
import '../home/model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<ProductModel>> getCartProducts(List<ProductModel> products) async {
    for (var product in products) {
      product.shoppingCart =
          await PreferencesManager().getBool("shoppingCart_${product.id}") ?? false;
    }

    return products.where((product) => product.shoppingCart).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      body: CustomQuery(
        builder: (products) {
          return FutureBuilder<List<ProductModel>>(
            future:  getCartProducts(products),
            builder: (context, snapshot) {
              final cartProducts = snapshot.data ?? [];

              if (cartProducts.isEmpty) {
                return CustomNoProduct(
                  refetch: () {},
                  title: 'No products in cart.', icon: Icons.shopping_cart,
                );
              }

              return CustomScrollView(
                slivers: [
                  CustomProduct(
                    products: cartProducts,
                    itemCount: cartProducts.length,
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
