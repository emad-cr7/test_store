class Queries {
  static const String getProducts = """
    query {
      products {
        id
        title
        price
        description
        images
        category {
          id
          name
          image
        }
      }
    }
  """;
}