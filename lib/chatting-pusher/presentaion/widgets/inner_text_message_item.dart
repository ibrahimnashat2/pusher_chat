import 'package:flutter/material.dart';
import 'package:pucher_chat/core/widget/context.dart';
import 'package:pucher_chat/core/widget/padding.dart';

import '../../../core/colors.dart';
import '../../../core/widget/text.dart';
import 'message_options_picker.dart';

class InnerTextMessageItem extends StatelessWidget {
  final String text;
  final String time;
  final Function onDelete;
  const InnerTextMessageItem({
    super.key,
    required this.onDelete,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onLongPress: () => showMessageOptions(context, onDelete),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: context.w * 0.65,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsetsDirectional.only(bottom: 3.0),
              decoration: const BoxDecoration(
                color: Coolors.secondColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(15.0),
                  bottomStart: Radius.circular(15.0),
                  topStart: Radius.circular(15.0),
                ),
              ),
              child: MText(
                text: text,
                maxLines: 100,
                fontColor: Colors.white,
                fontSize: 15.0,
              ),
            ),
            MText(
              text: time,
              fontColor: Coolors.secondColor,
              fontSize: 8.0,
            ).addPadding(bottom: 5.0)
          ],
        ),
      ),
    );
  }
}
