import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final Function(String t) validator;
  final Function(String t) onSaved;
  final Function(String t) onChanged;

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final int maxLength;
  final bool obscureText;

  const MyTextFormField({
    Key key,
    @required this.controller,
    @required this.validator,
    @required this.onSaved,
    @required this.onChanged,
    this.hintText,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) return androidBuildField(context);
    if (Platform.isIOS) return iosBuildField(context);
    return Center(child: Text("Couldn't recognize platform"));
  }

  iosBuildField(BuildContext context) {
    return CupertinoTextField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      placeholder: hintText,
      padding: EdgeInsets.all(10),
      clearButtonMode: OverlayVisibilityMode.editing,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(color: Theme.of(context).accentColor)),
      inputFormatters: [
        LengthLimitingTextInputFormatter(35),
      ],
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 16,
          ),
      onChanged: onChanged,
      onSubmitted: onSaved,
    );
  }

  androidBuildField(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
