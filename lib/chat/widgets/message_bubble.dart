import 'package:flutter/material.dart';
import 'package:send_bird_chat_app/core/index.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

import 'chat_status_widget.dart';

class TextMessageBubble extends StatelessWidget {
  final BaseMessage message;
  final String? messageText;

  const TextMessageBubble({Key? key, required this.message, this.messageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16)),
        color: (PresetColors.primary),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Text(message.message,
          style: const TextStyle(
            fontSize: 12,
            color: PresetColors.white,
          )),
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final BaseMessage message;
  final VoidCallback onTap;
  const UserMessageBubble(
      {Key? key, required this.message, required this.onTap})
      : super(key: key);

  String? get name =>
      message.sender?.nickname != null && message.sender?.nickname != ''
          ? message.sender?.nickname
          : 'Anonyms';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.sender?.profileUrl == null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CircleAvatar(
                radius: 20, // Set the radius as needed
                backgroundImage: NetworkImage(message.sender!.profileUrl),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: CircleAvatar(
                radius: 20,
                child:
                    Icon(Icons.person_2_outlined), // Set the radius as needed
              ),
            ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  color: (Colors.grey[900]),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                    Text(
                      message.message,
                      style: const TextStyle(
                          color: PresetColors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ChatTimeAndStatusWidget(message: message),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
