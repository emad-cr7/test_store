import 'package:flutter/material.dart';

import '../features/cart/cart_screen.dart';
import '../features/favorite/favorite_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';

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

  final List<_NavItemData> items = const [
    _NavItemData(icon: Icons.home_rounded, label: "Home"),
    _NavItemData(icon: Icons.favorite_rounded, label: "Favorite"),
    _NavItemData(icon: Icons.shopping_cart_rounded, label: "Cart"),
    _NavItemData(icon: Icons.person_rounded, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;

    return Scaffold(
      extendBody: true,

      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),

          Positioned(
            left: 20,
            right: 20,
            bottom: 12,

            child: SafeArea(
              top: false,

              child: Container(
                height: 68,

                decoration: BoxDecoration(
                  color: theme.cardColor,

                  borderRadius: BorderRadius.circular(40),

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
                            size: 30,
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
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      item.label,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: selectedColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox(width: 0, height: 0),
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
  final bool showBadge;

  const _NavItemData({
    required this.icon,
    required this.label,
    this.showBadge = false,
  });
}
