/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_images.dart';
import '../../../utils/ui_spacer.dart';

class Empty extends StatelessWidget {
  Empty(
      {super.key,
      required this.image,
      required this.info,
      required this.description});
  String image;
  String info;
  String description;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Image.asset(image)
            .wh(
              context.percentWidth * 50,
              context.percentWidth * 50,
            )
            .box
            .makeCentered()
            .wFull(context),
        UiSpacer.vSpace(5),
        info.text.semiBold.xl.make(),
        description.text.make(),
      ],
      crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.center,
    ).wFull(context);
  }
}
