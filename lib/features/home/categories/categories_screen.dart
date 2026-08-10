import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/home/categories/categories_controller.dart';

import '../model/category_model.dart';
import 'categories_data.dart';
import 'category_products_screen.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (BuildContext context)=> CategoriesController(),
      child: Consumer<CategoriesController>(
        builder: (context, controller, _) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category.id == controller.selectedCategoryId;

                  Future<void> handleTap() async {
                    controller.selectCategory(category.id!);

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryProductsScreen(category: category),
                      ),
                    );

                    if (context.mounted) {
                      controller.clearSelection();
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
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
        },
      ),
    );
  }
}

