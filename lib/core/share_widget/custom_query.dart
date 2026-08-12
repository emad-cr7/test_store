import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import '../../features/home/model/product_model.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';
import '../datasource/api/api_config/api_config.dart';
import '../datasource/api/query.dart';
import '../provider/provider_controller.dart';
import '../../features/favorite/favorite_controller.dart';
import '../../features/cart/cart_controller.dart';
import '../skeleton/skeleton_loading.dart';
import 'custom_no_product.dart';

class CustomQuery extends StatelessWidget {
  const CustomQuery({super.key, required this.builder});

  final Widget Function(List<ProductModel> products) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(Queries.getProducts)),
      builder: (result, {fetchMore, refetch}) {
        return Consumer3<ProviderController, FavoriteController, CartController>(
          builder: (context, controller, favoriteController, cartController, _) {
            if (result.isLoading) {
              return const SkeletonLoading();
            }

            if (result.hasException) {
              final isNetworkError =
                  result.exception.toString().contains('SocketException') ||
                  result.exception.toString().contains('Failed host lookup');

              return CustomNoProduct(
                refetch: refetch,
                title: isNetworkError
                    ? 'No internet connection'
                    : 'Something went wrong',
                icon: isNetworkError ? Icons.wifi_off : Icons.error,
              );
            }

            final productsJson = result.data?[ApiConfig.products] as List;
            final products = productsJson
                .map((json) => ProductModel.fromJson(json))
                .toList();

            for (var product in products) {
              product.isFavorite =
                  PreferencesManager().getBool("favorite_${product.id}") ??
                  false;
              product.shoppingCart =
                  PreferencesManager().getBool("shoppingCart_${product.id}") ??
                  false;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.allProducts.isEmpty) {
                controller.syncProducts(products);
                favoriteController.setProducts(products);
                cartController.setProducts(products);
                favoriteController.loadFavorites();
                cartController.loadCart();
              }
            });

            if (controller.allProducts.isEmpty ||
                favoriteController.isLoadingFirebase ||
                cartController.isLoadingFirebase) {
              return const SkeletonLoading();
            }

            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await refetch?.call();
              },
              child: builder(products),
            );
          },
        );
      },
    );
  }
}
