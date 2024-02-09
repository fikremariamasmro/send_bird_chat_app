part of 'chat_bloc.dart';

sealed class ChatEvent {}

class InitializeChat extends ChatEvent {}

class FetchChatMessages extends ChatEvent {}

class OpenChatChannel extends ChatEvent {
  final String channelUrl;
  final bool showLoading;
  OpenChatChannel(this.channelUrl, {this.showLoading = true});
}

class SendMessage extends ChatEvent {
  final String message;
  SendMessage(this.message);
}
