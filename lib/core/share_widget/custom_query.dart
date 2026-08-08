import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../features/home/model/product_model.dart';
import '../api/api_config/api_config.dart';
import '../api/query.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';
import 'custom_no_product.dart';

class CustomQuery extends StatelessWidget {
  const CustomQuery({super.key, required this.builder});

  final Widget Function(List<ProductModel> products) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(Queries.getProducts)),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue,
              size: 55,
            ),
          );
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
              PreferencesManager().getBool("favorite_${product.id}") ?? false;
        }
        for (var product in products) {
          product.shoppingCart =
              PreferencesManager().getBool("shoppingCart_${product.id}") ??
              false;
        }

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await refetch?.call();
          },
          child: builder(products),
        );
      },
    );
  }
}
