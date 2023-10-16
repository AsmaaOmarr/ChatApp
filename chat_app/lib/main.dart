// ignore_for_file: prefer_const_constructors
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chatscreen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "signIn": (context) => SignInScreen(),
        "signUp": (context) => SignUpScreen(),
        "chatScreen": (context) => ChatScreen(),
      },
      initialRoute: 'signIn',
      debugShowCheckedModeBanner: false,
    );
  }
}
