import 'chat/chat_page.dart';
import 'chat/bloc/chat_bloc.dart';
import 'core/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SendbirdChat.init(appId: LocalKeys.APP_ID);

  runApp(BlocProvider(
    create: (context) => ChatBloc(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Send Bird Chat App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        appBarTheme: const AppBarTheme(color: Colors.black),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          background: Colors.black,
        ),
      ),
      home: const ChatPage(),
    ),
  ));
}
