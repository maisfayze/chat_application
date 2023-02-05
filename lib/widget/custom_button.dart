import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  String? title;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('$title'),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff9e59aa),
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
