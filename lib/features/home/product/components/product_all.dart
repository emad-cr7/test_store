import 'package:flutter/material.dart';
import '../../../../core/share_widget/custom_product.dart';
import '../../../../core/share_widget/custom_query.dart';
import '../../model/product_model.dart';

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
          builder: (List<ProductModel> products) {
            return CustomScrollView(
              slivers: [
                CustomProduct(products: products, itemCount: products.length),
              ],
            );
          },
        ),
      ),
    );
  }
}
