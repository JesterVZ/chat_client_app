import 'package:flutter/material.dart';

abstract class AppUI{
  static const paddingZero = 0.0;
  static const paddingXS = 8.0;
  static const paddingS = 12.0;
  static const padding = 16.0;
  static const paddingL = 32.0;
  static const paddingXL = 33.0;



  static const progressIndicatorSize = 32.0;
  static const progressIndicatorSizeSmall = 16.0;
  static AppBar appBar({List<Widget>? actions, Widget? title }) => AppBar(actions: actions, title: title, centerTitle: true,);
}