import 'package:flutter/material.dart';

extension SetPadding on Widget {
  Widget addPadding({
    final double all = 0.0,
    final double horizontal = 0.0,
    final double vertical = 0.0,
    final double start = 0.0,
    final double bottom = 0.0,
    final double end = 0.0,
    final double top = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(all),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: start,
            bottom: bottom,
            end: end,
            top: top,
          ),
          child: this,
        ),
      ),
    );
  }
}
