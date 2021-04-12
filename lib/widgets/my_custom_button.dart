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
    return FlatButton(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: onTap,
      child: Text(
        text.toLowerCase(),
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
