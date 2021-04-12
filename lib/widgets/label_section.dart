import 'package:flutter/material.dart';

class LabelSection extends StatelessWidget {
  const LabelSection({
    Key key,
    this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class LeftTitle extends StatelessWidget {
  final Color tipColor;
  final String title;
  const LeftTitle({Key key, this.tipColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      child: Row(
        children: <Widget>[
          Container(
            color: tipColor,
            margin: EdgeInsets.only(right: 15),
            width: 3,
            height: 14,
          ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
