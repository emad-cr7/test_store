import 'package:flutter/material.dart';

import '../model/product_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.products, // ✅ أضفت استقبال قائمة المنتجات
  });

  final List<ProductModel> products; // ✅ أضفت متغير المنتجات

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  // ✅ أضفت ليست للنتائج بعد البحث
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    // ✅ أول ما الشاشة تفتح اعرض كل المنتجات
    filteredProducts = widget.products;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ✅ أضفت دالة البحث
  void search(String query) {
    setState(() {
      filteredProducts = widget.products.where((product) {
        return product.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: TextField(
          controller: searchController,

          // ✅ استدعاء البحث أثناء الكتابة
          onChanged: search,

          decoration: InputDecoration(
            hintText: "Search products...",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}