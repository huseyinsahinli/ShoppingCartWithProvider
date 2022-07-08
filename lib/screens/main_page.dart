import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/cart_provider.dart';
import 'package:trying/screens/cart_page.dart';

import 'product_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() {
          _selectedIndex = value;
        }),
        controller: pageController,
        children: [ProductPage(), BasketPage()],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xff1b1b1b),
              blurRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          selectedItemColor: Colors.green,
          showUnselectedLabels: false,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.shop_outlined),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: Badge(
                  badgeContent: Consumer<BasketProvider>(
                      builder: (context, value, child) {
                    return Text(value.getCounter().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ));
                  }),
                  animationDuration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              label: "Cart",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}
