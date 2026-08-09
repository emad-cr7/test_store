import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/share_widget/custom_no_product.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
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
      body: CustomQuery(
        builder: (products) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<ProviderController>().syncProducts(products);
          });

          return Consumer<ProviderController>(
            builder: (context, controller, _) {
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
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 105,
                    ),
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