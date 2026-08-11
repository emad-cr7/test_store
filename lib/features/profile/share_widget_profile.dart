import 'package:flutter/material.dart';

class ShareWidgetProfile extends StatelessWidget {
  const ShareWidgetProfile({
    super.key,
    required this.icon1,
    required this.titleList1,
    required this.onTap1,
    this.trailing1,

    this.icon2,
    this.titleList2,
    this.trailing2,
    this.onTap2,

    this.icon3,
    this.titleList3,
    this.trailing3,
    this.onTap3,
  });

  final IconData icon1;
  final String titleList1;
  final Widget? trailing1;
  final VoidCallback onTap1;

  final IconData? icon2;
  final String? titleList2;
  final Widget? trailing2;
  final VoidCallback? onTap2;

  final IconData? icon3;
  final String? titleList3;
  final Widget? trailing3;
  final VoidCallback? onTap3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon1),
              title: Text(titleList1),
              trailing: trailing1,
              onTap: onTap1,
            ),
            if (icon2 != null)
              ListTile(
                leading: Icon(icon2),
                title: Text(titleList2 ?? ''),
                trailing: trailing2,
                onTap: onTap2,
              ),
            if (icon3 != null)
              ListTile(
                leading: Icon(icon3),
                title: Text(titleList3 ?? ''),
                trailing: trailing3,
                onTap: onTap3,
              ),
          ],
        ),
      ),
    );
  }
}
