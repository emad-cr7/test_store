import 'package:flutter/material.dart';

import '../features/cart/cart_screen.dart';
import '../features/favorite/favorite_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../core/l10n/app_localizations.dart';
import '../core/theming/app_sizes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;
    final t = AppLocalizations.of(context)!;

    final List<_NavItemData> items = [
      _NavItemData(icon: Icons.home_rounded, label: t.navHome),
      _NavItemData(icon: Icons.favorite_rounded, label: t.navFavorite),
      _NavItemData(icon: Icons.shopping_cart_rounded, label: t.navCart),
      _NavItemData(icon: Icons.person_rounded, label: t.navProfile),
    ];

    return Scaffold(
      extendBody: true,

      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),

          Positioned(
            left: AppSizes.w20,
            right: AppSizes.w20,
            bottom: AppSizes.h12,

            child: SafeArea(
              top: false,

              child: Container(
                height: AppSizes.h68,

                decoration: BoxDecoration(
                  color: theme.cardColor,

                  borderRadius: BorderRadius.circular(AppSizes.r40),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.20),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    final isSelected = index == currentIndex;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,

                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            size: AppSizes.sp30,
                            color: isSelected
                                ? selectedColor
                                : theme.iconTheme.color?.withValues(
                                    alpha: 0.45,
                                  ),
                          ),

                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isSelected
                                ? Padding(
                                    padding: EdgeInsets.only(top: AppSizes.h3),
                                    child: Text(
                                      item.label,
                                      style: TextStyle(
                                        fontSize: AppSizes.sp13,
                                        fontWeight: FontWeight.w600,
                                        color: selectedColor,
                                      ),
                                    ),
                                  )
                                : SizedBox(width: AppSizes.w0, height: AppSizes.h0),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.label,
  });
}
