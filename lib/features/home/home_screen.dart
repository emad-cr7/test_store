import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ql/features/home/product/product_screen.dart';
import 'package:ql/features/home/search/search_screen.dart';
import 'package:ql/features/home/view_all/view_all_screen.dart';
import '../../api/api_config/api_config.dart';
import '../../api/query.dart';
import 'categories/categories_screen.dart';
import 'model/product_model.dart';
import 'no_internet/no_internet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Query(
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
            final products = productsJson
                .map((json) => ProductModel.fromJson(json))
                .toList();
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await refetch?.call();
              },
              child: CustomScrollView(
                slivers: [
                  SearchScreen(products: products),
                  Categories(),
                  ViewAllScreen(),
                  ProductScreen(products: products),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
