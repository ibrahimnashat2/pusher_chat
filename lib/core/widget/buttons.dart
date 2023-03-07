// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pusher_chat/core/widget.dart';
import 'package:pusher_chat/core/widget/context.dart';
import 'image.dart';

class MBackButton extends StatelessWidget {
  final bool backgroundGray;
  final Function? onBack;
  const MBackButton({
    super.key,
    this.backgroundGray = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: backgroundGray ? Colors.black12 : Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          CupertinoIcons.back,
          color: backgroundGray ? Colors.grey : Colors.black,
        ),
      ).addAction(onTap: () {
        if (onBack == null) {
          context.pop();
        } else {
          onBack!();
        }
      }),
    );
  }
}
