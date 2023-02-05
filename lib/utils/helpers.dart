import 'package:flutter/material.dart';

mixin Helpers{
void showSnackBar(BuildContext context,{required String message ,bool erorr =false  }){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:  Text(message),
      backgroundColor: erorr ? Colors.red.shade700 :Colors.blue.shade300,
      duration: Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}
}