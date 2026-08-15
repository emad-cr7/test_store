import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../core/share/widgets/custom_no_product.dart';
import '../../core/share/widgets/custom_product.dart';
import '../../core/provider/provider_controller.dart';
import '../../core/l10n/app_localizations.dart';
import 'favorite_controller.dart';
import '../../core/theming/app_sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.favorite,
          style: TextStyle(fontSize: AppSizes.sp24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer2<ProviderController, FavoriteController>(
        builder: (context, controller, favoriteController, _) {
          if (controller.allProducts.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue,
                size: AppSizes.sp55,
              ),
            );
          }

          final favoriteProducts = favoriteController.favoriteProducts;

          if (favoriteProducts.isEmpty) {
            return CustomNoProduct(
              refetch: () async{},
              title: t.noFavoriteProducts,
              icon: Icons.favorite,
            );
          }

          return CustomScrollView(
            slivers: [
              CustomProduct(
                products: favoriteProducts,
                itemCount: favoriteProducts.length,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.h105),
              ),
            ],
          );
        },
      ),
    );
  }
}