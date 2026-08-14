import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../datasource/remote/api_config.dart';

class GraphqlSetup {
  static HttpLink httpLink = HttpLink(ApiConfig.baseUrl);

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
}
