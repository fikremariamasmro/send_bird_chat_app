import 'package:flutter/material.dart';
import 'package:send_bird_chat_app/core/index.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';


class MessageStatusData {
  IconData iconData;
  Color color;
  MessageStatusData({required this.iconData, required this.color});
}

class MessagePayload {
  User? user;
  OpenChannel? openChannel;

  bool hasPrevious = false;
  List<BaseMessage> messageList = [];

  init() async {
    SendbirdChat.init(appId: LocalKeys.APP_ID);
    user =
        await SendbirdChat.connect(LocalKeys.USER_ID, nickname: "Fikremariam");
  }

  late PreviousMessageListQuery query;
}
