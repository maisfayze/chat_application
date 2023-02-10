import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnBoarding.id);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/s1.png',
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Message Me',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xffba68c8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
