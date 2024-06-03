import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:food_buddy/api/api_services.dart';
import 'package:food_buddy/constants/app_colors.dart';
import 'package:food_buddy/constants/app_images.dart';
import 'package:food_buddy/state/cart.dart';
import 'package:food_buddy/views/cart/widgets/empty.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../constants/api_constants.dart';
import '../../models/cart_item.dart';
import '../../utils/ui_spacer.dart';
import '../checkout/success.page.dart';
import '../widgets/amount_tile.dart';
import '../widgets/cart_list_item.dart';
import '../widgets/custom_list_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 2,
        title: "My Cart"
            .text
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .color(AppColor.whiteColor)
            .make(),
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            List<CartItem> cartItems = cartStore.cartItems.values.toList();
            int totalCartItems = cartStore.cartItems.length;
            double subTotalPrice = cartStore.subTotalPrice;
            double totalCartPrice = cartStore.totalCartPrice;

            return VStack(
              [
                if (cartItems.isEmpty)
                  Empty(
                          info: "Empty",
                          description: "Sorry, you have no items in your cart",
                          image: AppImages.emptyCart)
                      .centered()
                      .expand()
                else
                  VStack(
                    [
                      CustomListView(
                        dataSet: cartItems,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CartListItem(
                            cartItem,
                            onQuantityChange: (qty) {
                              if (qty > cartItem.selectedQty) {
                                cartStore.incrementItem(cartItem.id);
                              } else {
                                cartStore.decrementItem(cartItem.id);
                              }
                            },
                            deleteCartItem: () {
                              cartStore.deleteItem(cartItem.id);
                            },
                          );
                        },
                      ),
                      UiSpacer.divider(height: 20),
                      UiSpacer.verticalSpace(),
                      AmountTile("Total Item", totalCartItems.toString()),
                      AmountTile("Sub-Total", "$currencySymbol $subTotalPrice"),
                      AmountTile("Tax @ $tax",
                          "$currencySymbol ${(totalCartPrice - subTotalPrice).toStringAsFixed(2)}"),
                      DottedLine(dashColor: context.textTheme.bodyLarge!.color!)
                          .py12(),
                      AmountTile("Total", "$currencySymbol $totalCartPrice"),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            ApiService api = ApiService();
                            var response = await api.checkout();
                            if (response != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSuccess(
                                      amount: totalCartPrice.toString(),
                                    ),
                                  ));
                              cartStore.clearCart();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primaryColor),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            'Checkout | $currencySymbol $totalCartPrice'
                                .toUpperCase(),
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontFamily: 'medium',
                              fontSize: 13,
                            ),
                          ),
                        ).h(Vx.dp48).py32(),
                      ),
                    ],
                  )
                      .pOnly(bottom: context.mq.viewPadding.bottom)
                      .scrollVertical(padding: const EdgeInsets.all(20))
                      .expand(),
              ],
            );
          },
        ),
      ),
    );
  }
}
