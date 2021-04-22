import 'package:flutter/material.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:get/get.dart';
import 'components/tab_category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: Text('categories'.tr),
          leadingType: AppBarBackType.None,
        ),
        body: CategoryPageContainer(),
      ),
    );
  }
}
