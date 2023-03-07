// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MText extends StatelessWidget {
  final String? text;
  final Color fontColor;
  final double fontSize;
  String? fontFamily;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? maxWidth;
  final TextDecoration textDecoration;
  MText({
    Key? key,
    this.text = "",
    this.fontFamily,
    this.fontColor = Colors.black,
    this.fontSize = 22.0,
    this.maxLines,
    this.textAlign,
    this.maxWidth,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key) {
    if (text == '') {
      ttext = 'No data yet';
    } else {
      ttext = (text ?? "").replaceAll('null', '');
    }
  }
  late String ttext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Text(
        ttext,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          decoration: textDecoration,
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 20,
          height: 1.2,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );
  }
}

// typedef TextBuilder = String Function(
//   bool opertion,
//   String result1,
//   String result2,
// );
