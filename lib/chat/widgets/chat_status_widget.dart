// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:send_bird_chat_app/core/index.dart';
import 'package:send_bird_chat_app/chat/model/index.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class ChatTimeAndStatusWidget extends StatelessWidget {
  final BaseMessage message;
  const ChatTimeAndStatusWidget({Key? key, required this.message})
      : super(key: key);

  bool get isMine => LocalKeys.USER_ID == message.sender?.userId;

  @override
  Widget build(BuildContext context) {
    final icon = getIconData(message.sendingStatus!);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(parseDate(message.createdAt),
            style: const TextStyle(
              color: PresetColors.lightGray,
              fontSize: 8,
            )),
        const SizedBox(width: 4),
        if (isMine)
          Icon(
            icon.iconData,
            color: PresetColors.white,
            size: 12,
          ),
      ],
    );
  }

  MessageStatusData getIconData(SendingStatus status) {
    switch (status) {
      case SendingStatus.failed || SendingStatus.canceled:
        return MessageStatusData(
            iconData: Icons.error, color: PresetColors.failAlert);
      case SendingStatus.succeeded:
        return MessageStatusData(
            iconData: Icons.done, color: PresetColors.lightGray);
      case SendingStatus.pending:
        return MessageStatusData(
            iconData: Icons.pending, color: PresetColors.primary);
      default:
        return MessageStatusData(
          iconData: Icons.access_time,
          color: PresetColors.lightGray,
        );
    }
  }
}
