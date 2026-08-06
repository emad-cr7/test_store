import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/share_widget/custom_product.dart';
import '../../../../core/share_widget/custom_query.dart';
import '../../home_controller.dart';
import '../../model/product_model.dart';
import '../../search/search_screen.dart';

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
        child: CustomQuery(
          builder: (products) {
            final controller = context.read<HomeController>();
            controller.syncProducts(products);
            return Consumer<HomeController>(
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
            );
          },
        ),
      ),
    );
  }
}
