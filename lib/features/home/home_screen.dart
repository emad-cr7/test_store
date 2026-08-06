import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/home/search/search_screen.dart';
import 'package:ql/features/home/view_all/view_all_screen.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
import 'categories/categories_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Store',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: CustomQuery(
          builder: (products) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<HomeController>().syncProducts(products);
            });
            return Consumer<HomeController>(
              builder: (context, controller, _) {
                return CustomScrollView(
                  slivers: [
                    SearchScreen(),
                    Categories(),
                    ViewAllScreen(),
                    CustomProduct(
                      products: controller.filteredProducts,
                      itemCount: min(controller.filteredProducts.length, 10),
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