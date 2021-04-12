import 'package:flutter/material.dart';

class UnLoggedProfileTop extends StatelessWidget {
  const UnLoggedProfileTop({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign in to personalize',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ],
    );
  }
}
