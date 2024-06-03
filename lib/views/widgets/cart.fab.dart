/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_buddy/views/cart/cart.page.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../constants/app_colors.dart';
import '../../state/cart.dart';

class CartHomeFab extends StatelessWidget {
  const CartHomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Observer(
      builder: (_) {
        int totalCartItems = cartStore.cartItems.length;

        return FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColor.primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
          child: totalCartItems > 0
              ? const Icon(
            FlutterIcons.shopping_cart_faw,
            color: Colors.white,
          ).badge(
            position: VxBadgePosition.rightTop,
            count: totalCartItems,
            color: Colors.black,
            textStyle: context.textTheme.bodyLarge?.copyWith(
              color:  Colors.white,
              fontSize: 10,
            ),
          )
              : const Icon(
            FlutterIcons.shopping_cart_faw,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
