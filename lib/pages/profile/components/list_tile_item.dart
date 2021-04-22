import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListTileItem extends StatelessWidget {
  final String iconData;
  final String title;
  final int count;
  final Function onTap;

  const ListTileItem({
    Key key,
    @required this.iconData,
    @required this.title,
    this.count,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 35.0),
          child: Row(
            children: [
              SvgPicture.asset(
                iconData,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.8),
                height: 25,
              ),
              SizedBox(width: 15),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
