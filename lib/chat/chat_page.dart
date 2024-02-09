import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_bird_chat_app/core/index.dart';
import 'package:send_bird_chat_app/chat/widgets/index.dart';

import 'bloc/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late FocusNode _focusNode;
  late ChatBloc _channelBloc;
  late ScrollController _scrollController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _channelBloc = BlocProvider.of<ChatBloc>(context);
    _channelBloc.add(InitializeChat());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conversion screen',
          style: TextStyle(color: PresetColors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: PresetColors.white,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: PresetColors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 3),
              () => _channelBloc.add(InitializeChat()));
        },
        child: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatLoadedState || state is ChatMessageSentState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _focusNode.unfocus();
                _scrollToBottom();
              });
            }
            if (state is ChannelInitialized) {
              _channelBloc.add(
                  OpenChatChannel(LocalKeys.CHANNEL_URL, showLoading: true));
            }
            if (state is ChatMessageSentState) {
              _channelBloc.add(
                  OpenChatChannel(LocalKeys.CHANNEL_URL, showLoading: false));
            }
          },
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChannelInitializing || state is ConnectChatChannel) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => const LoadingChatListTile(),
                );
              } else if (state is ChatLoadedState) {
                return _itemBuilder(context, state);
              } else if (state is ErrorOccurredState) {
                return ErrorWidgetCard(
                  error: state.error,
                  onRetry: () => {
                    _channelBloc.add(OpenChatChannel(LocalKeys.CHANNEL_URL)),
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      bottomNavigationBar: MessageComposer(
        focusNode: _focusNode,
        messageController: _textController,
        onSendMessage: () => {
          _channelBloc.add(SendMessage(_textController.text)),
          _textController.clear(),
        },
      ),
    );
  }

  _scrollToBottom() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  _itemBuilder(BuildContext context, ChatLoadedState state) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        return ChatBubble(
          key: ValueKey(message.messageId),
          message: message,
          isMine: LocalKeys.USER_ID == message.sender?.userId,
        );
      },
    );
  }

  @override
  void dispose() {
    _channelBloc.close();
    _focusNode.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
