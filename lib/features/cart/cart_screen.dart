import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/provider/provider_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProviderController>(
        builder: (context, controller, _) {
          if (controller.allProducts.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue,
                size: 55,
              ),
            );
          }

          final cartProducts = controller.cartProducts;

          if (cartProducts.isEmpty) {
            return CustomNoProduct(
              refetch: () {},
              title: 'No products in cart.',
              icon: Icons.shopping_cart,
            );
          }

          return CustomScrollView(
            slivers: [
              CustomProduct(
                products: cartProducts,
                itemCount: cartProducts.length,
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