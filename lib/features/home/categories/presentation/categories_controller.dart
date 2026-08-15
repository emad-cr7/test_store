import 'package:flutter/material.dart';

class CategoriesController extends ChangeNotifier {
  String? _selectedCategoryId;

  String? get selectedCategoryId => _selectedCategoryId;

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCategoryId = null;
    notifyListeners();
  }
}