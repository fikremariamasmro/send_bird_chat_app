import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

import 'content_builder.dart';

class ChatBubble extends StatelessWidget {
  final BaseMessage message;
  final bool isMine;
  const ChatBubble({Key? key, required this.message, this.isMine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (isMine ? Alignment.topRight : Alignment.topLeft),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            messageContentBuilder(
              message,
              type: isMine
                  ? MessageTypes.textMessage
                  : MessageTypes.userMessage,
            )
          ],
        ),
      ),
    );
  }
}

class LoadingChatListTile extends StatelessWidget {
  const LoadingChatListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20, width: 100, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 16, width: 200, color: Colors.white),
                  ],
                ),
                const Divider(color: Colors.white)
              ],
            ),
          ),
          Container(height: 14, width: 70, color: Colors.white)
        ],
      ),
    );
  }
}
