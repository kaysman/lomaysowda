import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyCustomFooter extends StatelessWidget {
  const MyCustomFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("has köp ýüklemek üçin çekiň");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("Gaýtadan synanyşyň!");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("Has köp ýüklemek üçin goýberiň");
        } else {
          body = Text("Ählisi...");
        }
        return Container(
          height: 55,
          child: Center(child: body),
        );
      },
    );
  }
}
