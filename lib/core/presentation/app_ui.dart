import 'package:flutter/material.dart';

abstract class AppUI{
  static const progressIndicatorSize = 32.0;
  static const progressIndicatorSizeSmall = 16.0;
  static AppBar appBar({List<Widget>? actions, Widget? title }) => AppBar(actions: actions, title: title, centerTitle: true,);
}