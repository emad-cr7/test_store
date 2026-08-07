import 'dart:async';
import 'package:flutter/material.dart';
import '../Preferences_manager/preferences_manager.dart';
import '../../features/home/model/product_model.dart';

class ProviderController extends ChangeNotifier {
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
    notifyListeners();
  }

  void onSearchChanged(String query) {
    searchQuery = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      filteredProducts = _applyFilter(query);
      notifyListeners();
    });
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// save the favorite and shopping cart status to shared preferences and screen

  List<ProductModel> get favoriteProducts =>
      allProducts.where((p) => p.isFavorite).toList();

  List<ProductModel> get cartProducts =>
      allProducts.where((p) => p.shoppingCart).toList();


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
