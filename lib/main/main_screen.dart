import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: SizedBox(
        height: 80,
        child: SalomonBottomBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_rounded, size: 23),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              selectedColor: Colors.blue,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_rounded, size: 23),
              title: const Text(
                "Favorite",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              selectedColor: Colors.red,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_cart_rounded, size: 23),
              title: const Text(
                "Cart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              selectedColor: Colors.green,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.person_rounded, size: 23),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              selectedColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
