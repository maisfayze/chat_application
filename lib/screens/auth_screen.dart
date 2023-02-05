import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_application/screens/login.dart';
import 'package:chat_application/screens/reg_screen.dart';
import 'package:chat_application/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const id = 'AuthScreen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/s1.png',
                    width: 90,
                    height: 70,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Message Me',
                        textStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xff9e59aa),
                        ),
                      ),
                    ],
                    totalRepeatCount: 5,
                    pause: const Duration(milliseconds: 500),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  SizedBox(
                    height: 34,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                  title: 'Login',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  }),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  title: 'Register',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RegisterScreen.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
