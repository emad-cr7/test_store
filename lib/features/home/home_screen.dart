import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/home/search/search_screen.dart';
import 'package:ql/features/home/view_all/view_all_screen.dart';
import '../../core/share/widgets/custom_product.dart';
import '../../core/share/widgets/custom_query.dart';
import 'categories/presentation/screens/categories_screen.dart';
import '../../core/provider/provider_controller.dart';
import '../../core/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.store,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: CustomQuery(
          builder: (products) {
            return Consumer<ProviderController>(
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
                    const SliverToBoxAdapter(child: SizedBox(height: 80)),
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