import 'chat/chat_page.dart';
import 'chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
