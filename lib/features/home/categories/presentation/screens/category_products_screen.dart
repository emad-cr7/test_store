import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/provider/provider_controller.dart';

import '../../../models/category_model.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/share/widgets/custom_no_product.dart';
import '../../../../../core/share/widgets/custom_product.dart';
import '../localization/category_localization.dart';
import '../../../../../core/theming/app_sizes.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final categoryDisplayName = localizedCategoryName(context, category.id, category.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryDisplayName,
          style: TextStyle(fontSize: AppSizes.sp22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer<ProviderController>(
          builder: (context, controller, _) {
            final categoryProducts =
            controller.allProducts.where((p) =>
            p.category.id.toString() == category.id).toList();

            if (categoryProducts.isEmpty) {
              return CustomNoProduct(
                refetch: null,
                title: t.noProductsInCategory(categoryDisplayName),
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
