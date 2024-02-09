import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

import 'message_bubble.dart';

enum MessageTypes { textMessage, userMessage }

Widget messageContentBuilder(BaseMessage message, {MessageTypes? type}) {
  const unsupportedMessage = "Unsupported message type.";
  switch (type) {
    case MessageTypes.textMessage:
      return TextMessageBubble(message: message);
    case MessageTypes.userMessage:
      return UserMessageBubble(
        message: message,
        onTap: () {},
      );
    default:
      return TextMessageBubble(
        messageText: unsupportedMessage,
        message: message,
      );
  }
}
