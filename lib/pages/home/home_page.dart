import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/home/provider/home_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'components/grid_products.dart';
import 'components/swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          backgroundColor: Theme.of(context).canvasColor,
          leadingType: AppBarBackType.None,
        ),
        body: HomePageContainer(),
      ),
    );
  }
}

class HomePageContainer extends StatefulWidget {
  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = Provider.of<HomeProvider>(context);
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
                  onLoading: state.loadData,
                  onRefresh: () => state.initData(refresh: true),
                  footer: CustomFooter(
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
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      // sliders
                      SliverToBoxAdapter(
                        child: HeadSwiper(
                          bannerList: state.sliders,
                        ),
                      ),

                      // vip products
                      SliverToBoxAdapter(
                        child: GridProducts(
                          label: 'vip_products',
                          products: state.vipProducts,
                        ),
                      ),

                      // trand products
                      SliverToBoxAdapter(
                        child: GridProducts(
                          label: 'trand_products',
                          products: state.trandProducts,
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: GridProducts(
                          label: 'all_products',
                          products: state.allProducts,
                        ),
                      ),

                      /// all products by scrolling up
                    ],
                    // +
                    // _hotCommodity(state.hotList),
                  ),
                ),
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
