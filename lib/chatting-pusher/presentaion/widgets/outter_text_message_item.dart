import 'package:flutter/material.dart';
import 'package:pucher_chat/core/widget/context.dart';
import 'package:pucher_chat/core/widget/padding.dart';

import '../../../core/colors.dart';
import '../../../core/widget/text.dart';

class OutterTextMessageItem extends StatelessWidget {
  final String text;
  final String time;
  const OutterTextMessageItem({
    super.key,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: context.w * 0.65,
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsetsDirectional.only(bottom: 3.0),
            decoration: const BoxDecoration(
              color: Coolors.textFieldHintColor,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15.0),
                bottomEnd: Radius.circular(15.0),
                topStart: Radius.circular(15.0),
              ),
            ),
            child: MText(
              text: text,
              maxLines: 100,
              fontSize: 15.0,
            ),
          ),
          MText(
            text: time,
            fontColor: Coolors.blackColor,
            fontSize: 8.0,
          ).addPadding(bottom: 5.0)
        ],
      ),
    );
  }
}
