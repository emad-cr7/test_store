import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ql/features/home/search/search_screen.dart';
import 'package:ql/features/home/view_all/view_all_screen.dart';
import '../../core/share_widget/custom_product.dart';
import '../../core/share_widget/custom_query.dart';
import 'categories/categories_screen.dart';

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
            return CustomScrollView(
              slivers: [
                SearchScreen(),
                Categories(),
                ViewAllScreen(),
                CustomProduct(
                  products: products,
                  itemCount: min(products.length, 10),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
