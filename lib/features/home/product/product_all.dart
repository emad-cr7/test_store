import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/share/widgets/custom_product.dart';
import '../../../core/provider/provider_controller.dart';
import '../search/search_screen.dart';

class ProductAll extends StatelessWidget {
  const ProductAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer<ProviderController>(
          builder: (context, controller, _) {
            return CustomScrollView(
              slivers: [
                SearchScreen(),
                CustomProduct(
                  products: controller.filteredProducts,
                  itemCount: controller.filteredProducts.length,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}