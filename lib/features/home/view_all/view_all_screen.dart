import 'package:flutter/material.dart';
import '../product/components/product_all.dart';


class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Product",
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
                "View all",
                  style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
          ],
        ),
      ),
    );
  }
}
