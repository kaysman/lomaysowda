import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/home/components/grid_products.dart';
import 'package:lomaysowda/pages/view_my_products/provider/getproducts_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_custom_footer.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetProductsProvider(),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          leadingType: AppBarBackType.Back,
          title: Text('my_products'.tr),
        ),
        body: SafeArea(
          child: MyProductsPageContainer(),
        ),
      ),
    );
  }
}

class MyProductsPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GetProductsProvider>(context);
    return state.loading
        ? MyLoadingWidget()
        : Container(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: SmartRefresher(
                controller: state.refreshController,
                onRefresh: state.getUserProducts,
                footer: MyCustomFooter(),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      sliver: SliverToBoxAdapter(
                        child: GridProducts(
                          auth: true,
                          products: state.userProducts,
                        ),
                      ),
                    ),

                    /// all products by scrolling up
                  ],
                ),
              ),
            ),
          );
  }
}
