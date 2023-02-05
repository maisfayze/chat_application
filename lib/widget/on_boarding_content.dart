import 'package:flutter/cupertino.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key,
    required this.image,
    this.content,
  }) : super(key: key);

  final String image;

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/$image.png',
          height: 270,
        ),
      ],
    );
  }
}
