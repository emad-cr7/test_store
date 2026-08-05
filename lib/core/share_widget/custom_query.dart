import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../features/home/home_controller.dart';
import '../../features/home/model/product_model.dart';
import '../Preferences_manager/preferences_manager.dart';
import '../api/api_config/api_config.dart';
import '../api/query.dart';
import 'no_internet/no_internet.dart';

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

          return NoInternet(
            isNetworkError: isNetworkError,
            refetch: () async {
              await refetch?.call();
            },
          );
        }

        final productsJson = result.data?[ApiConfig.products] as List;
        final products =
        productsJson.map((json) => ProductModel.fromJson(json)).toList();

        for (var product in products) {
          product.isFavorite =
              PreferencesManager().getBool("favorite_${product.id}") ?? false;
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