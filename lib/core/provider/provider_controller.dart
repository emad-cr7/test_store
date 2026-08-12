import 'dart:async';
import 'package:flutter/material.dart';
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

  void resetOnLogout() {
    _debounce?.cancel();
    searchController.clear();
    searchQuery = '';

    filteredProducts = allProducts;
    notifyListeners();
  }

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
}
