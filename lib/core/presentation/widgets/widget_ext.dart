import 'package:flutter/material.dart';

extension ToExpanded on Widget {
  Widget toExpand({int? flex}) {

    return Expanded(flex: flex ?? 1,child: this,);
  }
}

extension AddPadding on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingZero(double padding) {
    return Padding(
      padding: EdgeInsets.zero,
      child: this,
    );
  }

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget paddingOnly({
    double bottom = 0,
    double left = 0,
    double right = 0,
    double top = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom,
        left: left,
        right: right,
        top: top,
      ),
      child: this,
    );
  }

    Widget paddingFromEdgeInsets(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
}