import 'package:flutter/material.dart';

import '../model/category_model.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
      
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      category.icon ?? Icons.category,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 70,
                    child: Text(
                      category.name ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
final List<CategoryModel> categories = [
  CategoryModel(
    id: '1',
    name: 'Mob',
    icon: Icons.phone_android,
  ),
  CategoryModel(
    id: '2',
    name: 'Shoes',
    icon: Icons.hiking,
  ),
  CategoryModel(
    id: '3',
    name: 'Furniture',
    icon: Icons.chair,
  ),
  CategoryModel(
    id: '4',
    name: 'Clothes',
    icon: Icons.checkroom,
  ),
  CategoryModel(
    id: '5',
    name: 'Toys',
    icon: Icons.toys,
  ),
];