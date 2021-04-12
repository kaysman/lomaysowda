import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/category/provider/category_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'components/tab_category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        leadingType: AppBarBackType.None,
        title: Text('categories'.tr),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
        child: CategoryPageContainer(),
      ),
    );
  }
}
