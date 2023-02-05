import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/custom_button.dart';
import '../widget/on_boarding_content.dart';
import 'auth_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);
  static const id = 'OnBoarding';
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int currentPage) {
                  setState(() => _currentPage = currentPage);
                },
                children: [
                  OnBoardingContent(
                    image: 'P1',
                  ),
                  OnBoardingContent(
                    image: 'P2',
                  ),
                  OnBoardingContent(
                    image: 'P3',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'A world without communication is meaningless.So you have to message every thing now!',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: _currentPage == 2,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AuthScreen.id);
                  },
                  title: 'Get Started',
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
