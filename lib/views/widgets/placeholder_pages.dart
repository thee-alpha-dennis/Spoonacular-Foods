/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../cart/widgets/empty.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder(
      {super.key,
      required this.title,
      required this.info,
      required this.image,
      required this.body});
  final String title;
  final String info;
  final String body;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 2,
        title: title.text
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .color(Colors.white)
            .make(),
      ),
      body: Center(
          child:
              Empty(info: info, description: body, image:image)
                  .centered()),
    );
  }
}
