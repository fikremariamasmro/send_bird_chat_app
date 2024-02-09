import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:send_bird_chat_app/core/index.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  User? user;
  OpenChannel? _openChannel;
  List<BaseMessage> _messages = [];

  ChatBloc() : super(ChannelInitializing()) {
    on<InitializeChat>(_onInitializeChanel);
    on<OpenChatChannel>(_onEnterLoadChat);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onInitializeChanel(
      InitializeChat event, Emitter<ChatState> emit) async {
    emit(ChannelInitializing());
    await SendbirdChat.init(appId: LocalKeys.APP_ID);
    user = await SendbirdChat.connect(LocalKeys.USER_ID, nickname: "fkl");
    emit(ChannelInitialized());
  }

  Future<void> _onEnterLoadChat(
      OpenChatChannel event, Emitter<ChatState> emit) async {
    if (event.showLoading) {
      emit(ConnectChatChannel());
    } else {
      emit(ChatLoadedState(_openChannel!, _messages));
    }

    try {
      _openChannel = await OpenChannel.getChannel(event.channelUrl);
      await _openChannel!.enter();
      final messages = await PreviousMessageListQuery(
        channelType: ChannelType.open,
        channelUrl: event.channelUrl,
      ).next();
      _messages = messages;
      emit(ChatLoadedState(_openChannel!, messages));
    } catch (e) {
      emit(ErrorOccurredState(e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      if (_openChannel == null) {
        throw Exception("OpenChannel instance is null");
      }
      _openChannel!
          .sendUserMessage(UserMessageCreateParams(message: event.message));
      emit(ChatMessageSentState());
    } catch (e) {
      emit(ErrorOccurredState(e.toString()));
    }
  }
}
