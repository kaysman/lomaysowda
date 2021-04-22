import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
        child: Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).primaryColor,
      ),
      child: CupertinoActivityIndicator(
        radius: size.width * 0.04,
      ),
    ));
  }
}
