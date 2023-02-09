import 'dart:async';
import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/chatScreen.dart';
import 'package:chat_application/screens/login.dart';
import 'package:chat_application/screens/notfications.dart';
import 'package:chat_application/screens/on_boarding.dart';
import 'package:chat_application/screens/reg_screen.dart';
import 'package:chat_application/screens/splach_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.subscribeToTopic("news");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  void getFcm() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm token is :$fcmToken');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getFcm();
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
        Notfications.id: (context) => Notfications(),
      },
    );
  }
}
