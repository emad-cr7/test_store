import 'package:flutter/material.dart';

import '../../core/Preferences_manager/preferences_manager.dart';
import 'model/product_model.dart';

class HomeController extends ChangeNotifier {


  List<ProductModel> products = [];

  void init(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void toggleFavorite(ProductModel product)async {
    product.isFavorite = !product.isFavorite;
    await PreferencesManager().setBool(
      "favorite_${product.id}",
      product.isFavorite,
    );
    notifyListeners();
  }

  void toggleShoppingCart(ProductModel product) {
    product.shoppingCart = !product.shoppingCart;
    notifyListeners();
  }
}