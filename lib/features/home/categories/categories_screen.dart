import 'package:flutter/material.dart';
import '../model/category_model.dart';
import 'category_products_screen.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category.id == selectedCategoryId;
            Future<void> handleTap() async {
              setState(() => selectedCategoryId = category.id);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryProductsScreen(category: category),
                ),
              );

              if (mounted) {
                setState(() => selectedCategoryId = null);
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: handleTap,
                child: Column(
                  children: [
                    ClipOval(
                      child: Material(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.dividerColor,
                        child: InkWell(
                          onTap: handleTap,
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Icon(
                              category.icon ?? Icons.category,
                              size: 30,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.primary,
                            ),
                          ),
                        ),
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// These ids/names match the categories returned by the API
// (https://api.escuelajs.co) so that filtering products by
// category.id in CategoryProductsScreen works correctly.
final List<CategoryModel> categories = [
  CategoryModel(
    id: '1',
    name: 'Clothes',
    icon: Icons.checkroom,
  ),
  CategoryModel(
    id: '2',
    name: 'Electronics',
    icon: Icons.devices_other,
  ),
  CategoryModel(
    id: '3',
    name: 'Furniture',
    icon: Icons.chair,
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    icon: Icons.hiking,
  ),
  CategoryModel(
    id: '5',
    name: 'Others',
    icon: Icons.category,
  ),
];