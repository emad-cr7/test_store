import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ql/home/model/product_model.dart';
import '../api/api_config/api_config.dart';
import '../api/query.dart';
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
      body: Query(
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
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: product.images[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('\$${product.price.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
