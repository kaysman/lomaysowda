import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/category/provider/category_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'components/tab_markets.dart';
import 'components/tab_category.dart';
import 'provider/markets_provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          leadingType: AppBarBackType.None,
          bottom: TabBar(
            indicatorColor: Color(0xFFD1C3BC),
            tabs: [
              Tab(
                text: 'markets'.tr,
              ),
              Tab(
                text: 'categories'.tr,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChangeNotifierProvider(
              create: (_) => MarketsProvider(),
              child: MarketsPage(),
            ),
            ChangeNotifierProvider(
              create: (_) => CategoryProvider(),
              child: CategoryPageContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
