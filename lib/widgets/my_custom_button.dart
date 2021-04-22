import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const MyCustomButton({
    Key key,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text.toUpperCase()),
    );
  }
}
