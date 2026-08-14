import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../datasource/remote/api_config.dart';

ValueNotifier<GraphQLClient> createGraphQLClient() {
  final httpLink = HttpLink(ApiConfig.baseUrl);
  return ValueNotifier(GraphQLClient(link: httpLink, cache: GraphQLCache()));
}
