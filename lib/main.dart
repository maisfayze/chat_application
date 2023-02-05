import 'dart:async';

import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/chatScreen.dart';
import 'package:chat_application/screens/login.dart';
import 'package:chat_application/screens/on_boarding.dart';
import 'package:chat_application/screens/reg_screen.dart';
import 'package:chat_application/screens/splach_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;

  @override

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _auth.currentUser == null ? SplashScreen.id : ChatScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnBoarding.id: (context) => OnBoarding(),
        AuthScreen.id: (context) => AuthScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
