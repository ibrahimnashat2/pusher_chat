// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:pusher_chat/core/widget/padding.dart';
import 'package:pusher_chat/core/widget/text.dart';

import '../colors.dart';

class MTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLength;
  final Color? fillColor;
  String? hintText;
  final String? lableText;
  final String? title;
  final double? textSize;
  final Color hintColor;
  final Color textColor;
  String? fontFamily;
  final double paddingHorizontal;
  final double? paddingVertical;
  Widget? suffix;
  Widget? prefix;
  final InputBorder? border;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool obscureText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  MTextFiled({
    Key? key,
    this.controller,
    this.focusNode,
    this.border,
    this.maxLength,
    this.fillColor,
    this.lableText,
    this.suffix,
    this.onEditingComplete,
    this.prefix,
    this.title,
    this.hintText,
    this.hintColor = Coolors.textFieldHintColor,
    this.textColor = Colors.black,
    this.textSize,
    this.paddingHorizontal = 0.0,
    this.paddingVertical,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textSize = textSize ?? 14;
    if (hintText == 'null') hintText = null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          MText(
            text: title,
            fontSize: 14.0,
          ).addPadding(bottom: border == null ? 0.0 : 8.0),
        TextFormField(
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          key: key,
          enableSuggestions: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          cursorColor: Coolors.primaryColor,
          cursorHeight: _textSize,
          style: TextStyle(
            fontSize: _textSize,
            color: textColor,
            fontFamily: fontFamily,
          ),
          validator: validator,
          decoration: InputDecoration(
            focusedBorder: hintText == null
                ? border?.copyWith(
                    borderSide: const BorderSide(color: Coolors.primaryColor),
                  )
                : border,
            labelStyle: TextStyle(
              fontSize: _textSize,
              fontFamily: fontFamily,
            ),
            border: border,
            enabledBorder: border,
            disabledBorder: border,
            suffixIcon: suffix,
            prefixIcon: prefix,
            filled: fillColor != null,
            fillColor: fillColor,
            hintText: hintText,
            labelText: hintText == null || hintText == '' ? lableText : null,
            hintStyle: TextStyle(
              fontSize: _textSize,
              color: hintColor,
              fontFamily: fontFamily,
            ),
            contentPadding: EdgeInsetsDirectional.only(
              start: paddingHorizontal,
              end: paddingHorizontal,
              bottom: paddingVertical ?? 2,
              top: paddingVertical ?? 2,
            ),
          ),
        ),
      ],
    );
  }
}
