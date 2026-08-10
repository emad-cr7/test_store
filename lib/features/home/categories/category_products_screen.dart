import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/provider_controller.dart';
import '../../../core/share_widget/custom_product.dart';
import '../../../core/share_widget/custom_no_product.dart';
import '../model/category_model.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name ?? 'Category',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer<ProviderController>(
          builder: (context, controller, _) {
            final categoryProducts = controller.allProducts
                .where((p) => p.category.id.toString() == category.id)
                .toList();

            if (categoryProducts.isEmpty) {
              return CustomNoProduct(
                refetch: null,
                title: 'No products in "${category.name}" yet',
                icon: Icons.category_outlined,
              );
            }

            return CustomScrollView(
              slivers: [
                CustomProduct(
                  products: categoryProducts,
                  itemCount: categoryProducts.length,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
