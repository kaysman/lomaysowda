import 'package:flutter/material.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'component/detailsection.dart';
import 'provider/product_provider.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final int id;
  const ProductDetailPage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailProvider(productId: id),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          backgroundColor: Theme.of(context).canvasColor,
          leadingType: AppBarBackType.Back,
          title: Text('product'.tr),
        ),
        body: Builder(
          builder: (context) => SafeArea(
            child: ProductDetailPageContainer(),
          ),
        ),
      ),
    );
  }
}

class ProductDetailPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductDetailProvider>(context);
    return state.loading ? MyLoadingWidget() : DetailSection();
  }
}
