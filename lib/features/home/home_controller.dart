import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/Preferences_manager/preferences_manager.dart';
import 'model/product_model.dart';

class HomeController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  String searchQuery = '';
  Timer? _debounce;

  List<ProductModel> _applyFilter(String query) => query.trim().isEmpty
      ? allProducts
      : allProducts
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

  void syncProducts(List<ProductModel> products) {
    allProducts = products;
    filteredProducts = _applyFilter(searchQuery);
  }

  void onSearchChanged(String query) {
    searchQuery = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      filteredProducts = _applyFilter(query);
      notifyListeners();
    });
  }

  /// save the favorite and shopping cart status to shared preferences

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
