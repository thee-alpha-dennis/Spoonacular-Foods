/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/ui_spacer.dart';

class AmountTile extends StatelessWidget {
  const AmountTile(this.title, this.amount, {this.amountStyle, super.key});

  final String title;
  final String amount;
  final TextStyle? amountStyle;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        title.text.make().expand(),
        UiSpacer.horizontalSpace(),
        amount.text.textStyle(amountStyle).make(),
      ],
    );
  }
}
