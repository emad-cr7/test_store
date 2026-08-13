import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../core/provider/provider_controller.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/share/widgets/custom_no_product.dart';
import '../../core/share/widgets/custom_product.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.cart,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer2<ProviderController, CartController>(
        builder: (context, controller, cartController, _) {
          if (controller.allProducts.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue,
                size: 55,
              ),
            );
          }

          final cartProducts = cartController.cartProducts;

          if (cartProducts.isEmpty) {
            return CustomNoProduct(
              refetch: () {},
              title: t.noProductsInCart,
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