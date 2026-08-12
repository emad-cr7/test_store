import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../features/home/model/product_model.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';
import '../datasource/service/firebase_service .dart';

class ProviderController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  String searchQuery = '';
  Timer? _debounce;
  bool isLoadingFirebase = false;

  List<ProductModel> _applyFilter(String query) => query.trim().isEmpty
      ? allProducts
      : allProducts
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList();


  /// يمسح كل بيانات اليوزر القديم من الذاكرة عند تسجيل الخروج
  void resetOnLogout() {
    _debounce?.cancel();
    searchController.clear();
    searchQuery = '';
    isLoadingFirebase = false;

    // امسح فلاجات الفيفوريت والكارت من المنتجات (لو محتفظ بيها كـ reference)
    for (final product in allProducts) {
      product.isFavorite = false;
      product.shoppingCart = false;
    }

    filteredProducts = allProducts;
    notifyListeners();
  }

  Future<void> syncProducts(List<ProductModel> products) async {
    allProducts = products;
    filteredProducts = _applyFilter(searchQuery);
    isLoadingFirebase = true;
    notifyListeners();

    await loadFirebaseData();
  }

  void onSearchChanged(String query) {
    searchQuery = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      filteredProducts = _applyFilter(query);
      notifyListeners();
    });
  }

  Future<void> loadFirebaseData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    isLoadingFirebase = true;
    notifyListeners();

    final favoriteIds =
    await FirebaseService().getFavorites(user.uid);

    final cartIds =
    await FirebaseService().getCart(user.uid);

    for (final product in allProducts) {
      product.isFavorite = favoriteIds.contains(product.id);
      product.shoppingCart = cartIds.contains(product.id);
    }

    isLoadingFirebase = false;
    notifyListeners();
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }



  List<ProductModel> get cartProducts =>
      allProducts.where((p) => p.shoppingCart).toList();




  void toggleShoppingCart(ProductModel product) async {
    product.shoppingCart = !product.shoppingCart;

    // SharedPreferences
    await PreferencesManager().setBool(
      "shoppingCart_${product.id}",
      product.shoppingCart,
    );
    notifyListeners();


    // Firebase
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseService().saveCart(
        userId: user.uid,
        productId: product.id,
        shoppingCart: product.shoppingCart,
      );
    }

    notifyListeners();
  }
}
