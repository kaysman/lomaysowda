import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).accentColor.withOpacity(0.3),
      height: 0.5,
      indent: 20,
      endIndent: 20,
    );
  }
}

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Color(0xA8DFDFDF),
      width: 1,
    );
  }
}
