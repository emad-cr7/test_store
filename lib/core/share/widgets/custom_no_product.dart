import 'package:flutter/material.dart';
import '../../theming/app_sizes.dart';

class CustomNoProduct extends StatelessWidget {
  const CustomNoProduct({
    super.key,
    required this.refetch,
    required this.title,
    required this.icon,
  });

  final Future<void> Function()? refetch;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await refetch?.call();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon , size: AppSizes.sp60, color: Colors.grey),
                  SizedBox(height: AppSizes.h16),
                  Text(title, style: TextStyle(fontSize: AppSizes.sp16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}