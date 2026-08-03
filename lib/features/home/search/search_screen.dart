import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

   @override
   void dispose() {
     searchController.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding:  EdgeInsets.symmetric( horizontal: 10, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: TextField(
          controller: searchController,
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
        )
      ),
    );
  }
}
