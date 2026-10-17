import 'package:flutter/material.dart';

extension ScreenExtentions on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get aspectRatio => MediaQuery.sizeOf(this).aspectRatio;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  void requestFocus([FocusNode? node]) =>
      FocusScope.of(this).requestFocus(node);

  void requestNewFocusNode() => requestFocus(FocusNode());
}
