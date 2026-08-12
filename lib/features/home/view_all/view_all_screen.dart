import 'package:flutter/material.dart';
import '../product/components/product_all.dart';
import '../../../core/l10n/app_localizations.dart';


class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.product,
              style: Theme.of(context).textTheme.titleLarge
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductAll(),
                  ),
                );
              },
              child: Text(
                t.viewAll,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.underline,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
