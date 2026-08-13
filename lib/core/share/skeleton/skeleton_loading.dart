import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/provider/provider_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../features/home/categories/categories_screen.dart';
import '../../../features/home/search/search_screen.dart';
import '../../../features/home/view_all/view_all_screen.dart';
import 'custom_product_skeleton.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading ({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Consumer<ProviderController>(
        builder: (context, controller, _) {
          return CustomScrollView(
            slivers: [
              SearchScreen(),
              Categories(),
              ViewAllScreen(),
              CustomProductSkeleton(),
            ],
          );
        },
      ),
    );
  }
}
