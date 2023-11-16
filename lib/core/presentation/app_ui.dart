import 'package:flutter/material.dart';

abstract class AppUI{
  static AppBar appBar({List<Widget>? actions, Widget? title }) => AppBar(actions: actions, title: title, centerTitle: true,);
}