import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {Key? key,
      this.obsecure,
      this.hint,
      this.FieldLabel,
      this.onChanged,
      this.type,
      this.icon})
      : super(key: key);
  bool? obsecure;
  String? hint;
  String? FieldLabel;
  Function(String)? onChanged;
  TextInputType? type = TextInputType.text;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      obscureText: obsecure!,
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xff5d3464),
            size: 16,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0xff9e59aa),
          ),
          label: Text(
            '$FieldLabel',
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5d3464)),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5d3464)),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5d3464)),
              borderRadius: BorderRadius.circular(8))),
    );
  }
}
