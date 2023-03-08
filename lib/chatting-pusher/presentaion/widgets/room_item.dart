// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pusher_chat/core/colors.dart';
import 'package:pusher_chat/core/widget/context.dart';
import 'package:pusher_chat/core/widget/padding.dart';

import '../../../core/widget/image.dart';
import '../../../core/widget/text.dart';
import '../../../core/date_time.dart';
import '../../domain/entities/chat_room.dart';

class RoomItem extends StatelessWidget {
  final ChatRoom room;

  const RoomItem({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    final type = room.lastMessage?.contains('.mp3') ?? false
        ? "Voice"
        : room.lastMessage?.contains('http') ?? false
            ? 'Image'
            : room.lastMessage;
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MNetworkImage(
                width: 80,
                height: 80,
                url: room.user.image,
                borderRadius: 30.0,
                fit: BoxFit.cover,
              ).addPadding(end: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(
                    text: room.user.name,
                    fontSize: 16.0,
                    fontColor: Coolors.blackColor,
                  ).addPadding(bottom: 4.0),
                  MText(
                    text: type,
                    fontSize: 12.0,
                    maxLines: 3,
                    maxWidth: context.w * 0.35,
                    fontColor: Coolors.blackColor,
                  ),
                  if (room.lastCustomerService != null)
                    MText(
                      text: room.lastCustomerService,
                      fontSize: 10.0,
                      fontColor: Coolors.blackColor,
                    ),
                ],
              ),
            ],
          ),
          MText(
            text: room.lastUpdated?.timeOnly,
            fontSize: 12.0,
            fontColor: Coolors.blackColor,
          ),
        ],
      ),
    );
  }
}
