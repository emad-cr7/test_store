import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/models/product_model.dart';
import '../../core/datasource/local/preferences_manager.dart';
import '../../core/datasource/remote/firebase_service .dart';

/// Controller مسؤول فقط عن منطق الـ Favorite (بعد فصله عن ProviderController)
class FavoriteController extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool isLoadingFirebase = false;

  /// نفس الـ List بتاعة ProviderController.allProducts (reference واحدة)
  /// عشان أي تغيير في isFavorite يبان في كل الشاشات.
  void setProducts(List<ProductModel> products) {
    _products = products;
  }

  List<ProductModel> get favoriteProducts =>
      _products.where((p) => p.isFavorite).toList();

  void resetOnLogout() {
    isLoadingFirebase = false;

    for (final product in _products) {
      product.isFavorite = false;
    }

    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    isLoadingFirebase = true;
    notifyListeners();

    final favoriteIds = await FirebaseService().getFavorites(user.uid);

    for (final product in _products) {
      product.isFavorite = favoriteIds.contains(product.id);
    }

    isLoadingFirebase = false;
    notifyListeners();
  }

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
