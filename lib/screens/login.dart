import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble_loader/bubble_loader.dart';
import 'package:chat_application/screens/reg_screen.dart';
import 'package:chat_application/utils/helpers.dart';
import 'package:chat_application/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/custom_text_filed.dart';
import 'chatScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  final _auth = FirebaseAuth.instance;
  late TapGestureRecognizer _tapGestureRecognizer;
  late String email;
  late String pass;
  bool loading = false;
  // void getLoginStates() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLoginStates();

    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacementNamed(context, RegisterScreen.id);
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? BubbleLoader(
                color1: Colors.deepPurple,
                color2: Color(0xff9e59aa),
                bubbleGap: 10,
                bubbleScalingFactor: 1,
                duration: Duration(milliseconds: 1500),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
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
                                'Login',
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
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomTextFiled(
                        type: TextInputType.emailAddress,
                        obsecure: false,
                        onChanged: (value) {
                          email = value;
                        },
                        hint: 'Email Address',
                        FieldLabel: 'Enter Your Email Address',
                        icon: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextFiled(
                        type: TextInputType.emailAddress,
                        obsecure: true,
                        onChanged: (value) {
                          pass = value;
                        },
                        hint: 'Password',
                        FieldLabel: 'Enter Your Password',
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                          title: 'LOGIN',
                          onPressed: () async {
                            if (email != null && pass != null) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                final newUser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email.trim(),
                                        password: pass.trim());
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    ChatScreen.id,
                                    ModalRoute.withName(LoginScreen.id));
                                showSnackBar(context,
                                    message:
                                        'Login  process succes ${newUser.user!.email}',
                                    erorr: false);
                              } catch (e) {
                                showSnackBar(context,
                                    message: '${e.toString()}', erorr: true);
                              }
                            } else {
                              showSnackBar(context,
                                  message: 'The rigistriation process succes',
                                  erorr: true);
                            }
                            setState(() {
                              loading = false;
                            });

                            // print(pass);
                            // print(email);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        // alignment: AlignmentDirectional.center,
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account',
                              style: GoogleFonts.nunito(
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(text: '  '),
                                TextSpan(
                                  text: 'Create Now !',
                                  recognizer: _tapGestureRecognizer,
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF7530FF),
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
