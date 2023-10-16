// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String labelText;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool isObscure ;
  CustomTextField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.validator,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: TextFormField(
        obscureText: isObscure,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: 'Enter Your $labelText',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
