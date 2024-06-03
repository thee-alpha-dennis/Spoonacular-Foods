/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import 'package:food_buddy/constants/api_constants.dart';
import 'package:food_buddy/constants/app_images.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/app_colors.dart';
import '../cart/widgets/empty.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key, required this.amount});
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 2,
        title: "Checkout Success"
            .text
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .color(Colors.white)
            .make(),
      ),
      body: Center(
          child: Empty(
                  info: "Order was successful",
                  description:
                      "You placed an order worth $currencySymbol. $amount",
                  image: AppImages.checkoutSuccess)
              .centered()),
    );
  }
}
