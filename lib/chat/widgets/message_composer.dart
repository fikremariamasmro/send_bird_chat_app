import 'package:flutter/material.dart';
import 'package:send_bird_chat_app/core/index.dart';

class MessageComposer extends StatefulWidget {
  const MessageComposer({
    super.key,
    required this.focusNode,
    required this.messageController,
    required this.onSendMessage,
  });
  final FocusNode focusNode;
  final VoidCallback onSendMessage;
  final TextEditingController messageController;

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  bool _hasText = false;

  void _updateHasText() {
    setState(() {
      _hasText = widget.messageController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.messageController.addListener(_updateHasText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              //TODO handle file uploader
            },
            icon: const Icon(Icons.add, color: PresetColors.lightGray),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: PresetColors.lightDark,
                border: Border.all(color: Colors.white24),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: TextField(
                autofocus: false,
                controller: widget.messageController,
                focusNode: widget.focusNode,
                style: const TextStyle(color: PresetColors.white),
                decoration: InputDecoration(
                    hintText: "Type message",
                    hintStyle: const TextStyle(color: PresetColors.gray),
                    border: InputBorder.none,
                    suffix: _hasText
                        ? InkWell(
                            onTap: widget.onSendMessage,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 2),
                              child: Container(
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: PresetColors.primary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.arrow_upward_rounded,
                                    color: PresetColors.dark,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.messageController.removeListener(_updateHasText);
    super.dispose();
  }
}
