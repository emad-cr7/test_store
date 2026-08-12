import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../features/home/model/product_model.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';
import '../datasource/service/firebase_service .dart';

/// Controller مسؤول فقط عن منطق الـ Cart (بعد فصله عن ProviderController)
class CartController extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool isLoadingFirebase = false;

  /// نفس الـ List بتاعة ProviderController.allProducts (reference واحدة)
  /// عشان أي تغيير في shoppingCart يبان في كل الشاشات.
  void setProducts(List<ProductModel> products) {
    _products = products;
  }

  List<ProductModel> get cartProducts =>
      _products.where((p) => p.shoppingCart).toList();

  /// يمسح كل بيانات الكارت القديمة عند تسجيل الخروج
  void resetOnLogout() {
    isLoadingFirebase = false;

    for (final product in _products) {
      product.shoppingCart = false;
    }

    notifyListeners();
  }

  Future<void> loadCart() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    isLoadingFirebase = true;
    notifyListeners();

    final cartIds = await FirebaseService().getCart(user.uid);

    for (final product in _products) {
      product.shoppingCart = cartIds.contains(product.id);
    }

    isLoadingFirebase = false;
    notifyListeners();
  }

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
