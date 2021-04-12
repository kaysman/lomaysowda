import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String title;
  final dynamic trailing;

  const Tile({Key key, @required this.title, @required this.trailing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Spacer(),
          Expanded(
            flex: 4,
            child: Text(
              trailing ?? 'unknown',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
