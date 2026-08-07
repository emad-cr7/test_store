import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/provider_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProviderController>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: TextField(
          controller: controller.searchController,
          onChanged: (value) {
            controller.onSearchChanged(value);
          },
          decoration: InputDecoration(
            hintText: "Search products...",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade200,
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
              borderSide: const BorderSide(color: Colors.blue, width: 2),
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
