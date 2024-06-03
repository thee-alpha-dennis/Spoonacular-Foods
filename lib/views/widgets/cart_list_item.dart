/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_buddy/constants/app_colors.dart';
import 'package:food_buddy/constants/app_images.dart';
import 'package:food_buddy/models/cart_item.dart';
import 'package:food_buddy/views/widgets/qty_stepper.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/api_constants.dart';
import '../../utils/ui_spacer.dart';

class CartListItem extends StatefulWidget {
  const CartListItem(
      this.cartItem, {
        required this.onQuantityChange,
        this.deleteCartItem,
        super.key,
      });

  final CartItem cartItem;
  final Function(int) onQuantityChange;
  final Function? deleteCartItem;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HStack(
          [
            //PRODUCT IMAGE
            ClipRRect(
              child: FadeInImage(
                width: context.percentWidth * 18,
                height: context.percentWidth * 18,
                image: NetworkImage(widget.cartItem.photo),
                placeholder: const AssetImage(AppImages.error),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      width: context.percentWidth * 18,
                      height: context.percentWidth * 18,
                      AppImages.error,
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
            ).box.clip(Clip.antiAlias).roundedSM.make(),
                       //
            UiSpacer.hSpace(10),
            VStack(
              [
                //product name
                widget.cartItem.name
                    .text
                    .medium
                    .sm
                    .maxLines(2)
                    .ellipsis
                    .make(),
                UiSpacer.vSpace(10),

                //price and qty
                HStack(
                  [
                    //cart item price
                    ("$currencySymbol ${widget.cartItem.price}")
                        .text
                        .semiBold
                        .medium.color(AppColor.greenColor)
                        .make(),
                    10.widthBox.expand(),
                    //qty stepper
                    SizedBox(
                      height: 35,
                      child: FittedBox(
                        child: QtyStepper(
                          defaultValue: widget.cartItem.selectedQty ?? 1,
                          min: 1,
                          max:maxAddToCartQuantity,
                          disableInput: true,
                          onChange: widget.onQuantityChange,
                        )
                            .box
                            .color(context.theme.colorScheme.background)
                            .roundedSM
                            .clip(Clip.antiAlias)
                            .outerShadow
                            .make(),
                      ),
                    ),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ),
              ],
            ).expand(),
          ],
          alignment: MainAxisAlignment.start,
          crossAlignment: CrossAxisAlignment.start,
        )
            .p12()
            .box
            .roundedSM
            .outerShadowSm
            .color(context.theme.colorScheme.background)
            .make(),

        //
        //delete icon
        const Icon(
          FlutterIcons.x_fea,
          size: 16,
          color: Colors.white,
        )
            .p8()
            .onInkTap(
          widget.deleteCartItem != null ? () => widget.deleteCartItem!() : null,
        )
            .box
            .roundedSM
            .color(Colors.red)
            .make()
            .positioned(
          top: 0,
          left: 0,
        ),
      ],
    );
  }
}

