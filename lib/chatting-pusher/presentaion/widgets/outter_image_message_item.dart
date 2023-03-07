import 'package:flutter/material.dart';
import 'package:pusher_chat/core/widget.dart';
import 'package:pusher_chat/core/widget/context.dart';
import 'package:pusher_chat/core/widget/padding.dart';

import '../../../core/colors.dart';
import '../../../core/widget/image.dart';
import '../../../core/widget/text.dart';
import '../views/image_viewer_screen.dart';

class OutterImageMessageItem extends StatelessWidget {
  final String url;
  final String time;
  const OutterImageMessageItem({
    super.key,
    required this.url,
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
              minWidth: context.w * 0.4,
              maxWidth: context.w * 0.65,
              maxHeight: context.h * 0.3,
              minHeight: context.h * 0.22,
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
            child: MNetworkImage(
              url: url,
              fit: BoxFit.fitWidth,
            ).addAction(
                onTap: () => context.push(ImageViewerScreen(path: url))),
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
