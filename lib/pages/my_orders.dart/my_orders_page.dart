import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/my_orders.dart/components/grid_order.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_custom_footer.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'provider.dart/getorders_provider.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetOrdersProvider(),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          leadingType: AppBarBackType.Back,
          title: Text('My Orders'),
        ),
        body: SafeArea(
          child: MyOrdersPageContainer(),
        ),
      ),
    );
  }
}

class MyOrdersPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GetOrdersProvider>(context);
    return state.loading
        ? MyLoadingWidget()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: SmartRefresher(
                  controller: state.refreshController,
                  enablePullUp: true,
                  onRefresh: state.getUserOrders,
                  onLoading: state.loadMoreProducts,
                  footer: MyCustomFooter(),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: GridOrders(
                          orders: state.userOrders,
                        ),
                      ),

                      /// all brands by scrolling up
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
