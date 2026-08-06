import 'package:flutter/material.dart';

import '../../core/Preferences_manager/preferences_manager.dart';
import 'model/product_model.dart';

class HomeController extends ChangeNotifier {
  void toggleFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;
    await PreferencesManager().setBool(
      "favorite_${product.id}",
      product.isFavorite,
    );
    notifyListeners();
  }

  void toggleShoppingCart(ProductModel product) async {
    product.shoppingCart = !product.shoppingCart;
    await PreferencesManager().setBool(
      "shoppingCart_${product.id}",
      product.shoppingCart,
    );
    notifyListeners();
  }
}
