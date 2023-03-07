import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/colors.dart';

class OutterTypeItem extends StatelessWidget {
  const OutterTypeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        margin: const EdgeInsetsDirectional.only(bottom: 12.0),
        decoration: const BoxDecoration(
          color: Coolors.textFieldHintColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15.0),
            bottomEnd: Radius.circular(15.0),
            topStart: Radius.circular(15.0),
          ),
        ),
        child: LoadingAnimationWidget.waveDots(
          color: Coolors.secondColor,
          size: 30.0,
        ),
      ),
    );
  }
}
