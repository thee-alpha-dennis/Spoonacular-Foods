/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';

class UiSpacer {
  static Widget emptySpace() => const SizedBox(width: 0, height: 0);
  static Widget expandedSpace() => const Expanded(
    child: SizedBox.shrink(),
  );
  static Widget divider({double height = 1, double thickness = 1}) => Divider(
    height: height,
    thickness: thickness,
  );
  static Widget hSpace([double space = 20]) => SizedBox(width: space);
  static Widget verticalSpace({double space = 20}) => SizedBox(height: space);
  static Widget horizontalSpace({double space = 20}) => SizedBox(width: space);
  static Widget vSpace([double space = 20]) => SizedBox(height: space);
}
