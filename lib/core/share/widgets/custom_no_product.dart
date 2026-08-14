import 'package:flutter/material.dart';

class CustomNoProduct extends StatelessWidget {
  const CustomNoProduct({
    super.key,
    required this.refetch,
    required this.title,
    required this.icon,
  });

  final Function()? refetch;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => refetch?.call(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(icon , size: 60, color: Colors.grey),
                   SizedBox(height: 16),
                  Text(title, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
