/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present.
*/
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_buddy/constants/app_images.dart';
import 'package:food_buddy/views/food/food_items.dart';
import 'package:food_buddy/views/widgets/cart.fab.dart';
import 'package:food_buddy/views/widgets/placeholder_pages.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageViewController = PageController();
  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onTabChange(int index) {
    pageViewController.jumpToPage(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close",
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: pageViewController,
            onPageChanged: onPageChanged,
            children: const [
              MenuPage(),
              PlaceHolder(
                title: "Orders",
                image: AppImages.noOrders,
                body: "No orders placed at the moment",
                info: "My Orders",
              ),
              PlaceHolder(
                title: "Search",
                image: AppImages.noSearch,
                body: "No history captured yet",
                info: "Search history",
              ),
              PlaceHolder(
                title: "Profile",
                image: AppImages.user,
                info: "My profile",
                body: "Feature coming soon",
              ),
            ],
          ),
        ),
        floatingActionButton: const CartHomeFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          backgroundColor: Theme.of(context).colorScheme.background,
          blurEffect: true,
          shadow: BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
          ),
          activeIndex: currentIndex,
          onTap: onTabChange,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 14,
          rightCornerRadius: 14,
          tabBuilder: (int index, bool isActive) {
            final color = isActive
                ? AppColor.primaryColor
                : Theme.of(context).textTheme.bodyLarge?.color;
            List<String> titles = [
              "Home",
              "Orders",
              "Search",
              "More",
            ];
            List<IconData> icons = [
              FlutterIcons.home_ant,
              FlutterIcons.inbox_ant,
              FlutterIcons.search_fea,
              FlutterIcons.menu_fea,
            ];

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[index],
                  size: 20,
                  color: color,
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: titles[index]
                      .text
                      .fontFamily('regular')
                      .fontWeight(
                        isActive ? FontWeight.bold : FontWeight.normal,
                      )
                      .color(color)
                      .make(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
