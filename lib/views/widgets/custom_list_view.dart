/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:flutter/material.dart';
import '../../utils/ui_spacer.dart';

class CustomListView extends StatelessWidget {
  //
  final ScrollController? scrollController;
  final Widget? title;
  final List<dynamic> dataSet;
  final bool reversed;
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;

  const CustomListView({
    required this.dataSet,
    this.scrollController,
    this.title,
    this.reversed = false,
    this.scrollDirection = Axis.vertical,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  Widget _getBody() {
    final contentBody = _getListView();
    return contentBody;
  }

  Widget _getListView() {
    return ListView.separated(
      controller: scrollController,
      padding: padding,
      shrinkWrap: true,
      reverse: reversed,
      physics: const NeverScrollableScrollPhysics() ,
      scrollDirection: scrollDirection,
      itemBuilder: itemBuilder,
      itemCount: dataSet.length,
      separatorBuilder: separatorBuilder ??
              (context, index) => scrollDirection == Axis.vertical
              ? UiSpacer.verticalSpace()
              : UiSpacer.horizontalSpace(),
    );
  }
}
