part of 'chat_bloc.dart';

abstract class ChatState {}

class ChannelInitializing extends ChatState {}

class ChannelInitialized extends ChatState {}

class ConnectChatChannel extends ChatState {}

class ChatLoadedState extends ChatState {
  final OpenChannel channel;
  final List<BaseMessage> messages;
  ChatLoadedState(this.channel, this.messages);
}

class ChatMessageSentState extends ChatState {}

class ErrorOccurredState extends ChatState {
  final String error;
  ErrorOccurredState(this.error);
}
