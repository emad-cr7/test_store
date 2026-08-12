import 'package:flutter/material.dart';

import '../../core/datasource/Preferences_manager/preferences_manager.dart';
import '../home/model/product_model.dart';

class FavoriteController extends ChangeNotifier {
  List<ProductModel> allProducts = [];

  List<ProductModel> get favoriteProducts =>
      allProducts.where((p) => p.isFavorite).toList();

  void toggleFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;

    await PreferencesManager().setBool(
      "favorite_${product.id}",
      product.isFavorite,
    );
    notifyListeners();


    // حفظ في Firebase
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseService().saveFavorite(
        userId: user.uid,
        productId: product.id,
        isFavorite: product.isFavorite,
      );
    }

    notifyListeners();
  }

}