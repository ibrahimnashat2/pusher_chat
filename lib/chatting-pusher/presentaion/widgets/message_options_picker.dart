import 'package:customer_service/core/extensions.dart';
import 'package:customer_service/core/widgets/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/text.dart';

class MessageOptions extends StatelessWidget {
  final Function onDelete;
  const MessageOptions({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () => onDelete(),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.delete,
                        size: 22.0,
                      ).addPadding(end: 12.0),
                      MText(
                        text: 'Delete Message',
                        fontSize: 12.0,
                      ),
                    ],
                  ),
                ),
                const Divider().addPadding(vertical: 12.0),
                InkWell(
                  onTap: () => context.pop(),
                  child: MText(
                    text: 'Cancel',
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

showMessageOptions(BuildContext context, Function onDelete) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => MessageOptions(onDelete: onDelete),
  );
}
