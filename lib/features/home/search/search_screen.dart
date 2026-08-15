import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/provider_controller.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theming/app_sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProviderController>();
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w10, vertical: AppSizes.ph20),
      sliver: SliverToBoxAdapter(
        child: TextField(
          controller: controller.searchController,
          onChanged: (value) {
            controller.onSearchChanged(value);
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchProducts,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
