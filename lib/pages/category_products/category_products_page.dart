import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/category_products/provider/category_products_provider.dart';
import 'package:lomaysowda/pages/home/components/grid_products.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryProductsPage extends StatelessWidget {
  final int categoryID;
  final String categoryName;
  const CategoryProductsPage({Key key, this.categoryID, this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryProductsProvider(categoryId: categoryID),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          backgroundColor: Theme.of(context).canvasColor,
          leadingType: AppBarBackType.None,
        ),
        body: CategoryProductsPageContainer(name: categoryName),
      ),
    );
  }
}

class CategoryProductsPageContainer extends StatefulWidget {
  final String name;

  const CategoryProductsPageContainer({Key key, this.name}) : super(key: key);
  @override
  _CategoryProductsPageContainerState createState() =>
      _CategoryProductsPageContainerState();
}

class _CategoryProductsPageContainerState
    extends State<CategoryProductsPageContainer> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CategoryProductsProvider>(context);
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
                  onRefresh: () => state.getData(refresh: true),
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
                      SliverToBoxAdapter(
                        child: GridProducts(
                          label: widget.name,
                          products: state.products,
                        ),
                      ),

                      /// all products by scrolling up
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
