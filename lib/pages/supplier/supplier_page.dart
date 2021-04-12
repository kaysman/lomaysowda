import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/home/components/grid_products.dart';
import 'package:lomaysowda/widgets/custom_tile.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'provider/supplier_provider.dart';

class SupplierPage extends StatelessWidget {
  final int id;

  const SupplierPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SupplierProvider(supplierId: id),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          leadingType: AppBarBackType.Back,
          title: Text('productd_all_products'.tr),
        ),
        body: SafeArea(
          child: SupplierPageContainer(),
        ),
      ),
    );
  }
}

class SupplierPageContainer extends StatefulWidget {
  @override
  _SupplierPageContainerState createState() => _SupplierPageContainerState();
}

class _SupplierPageContainerState extends State<SupplierPageContainer> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SupplierProvider>(context);
    return state.loading
        ? MyLoadingWidget()
        : Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.supplier.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "provider_brands".tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  state.supplier.brands.list.length == 0
                      ? Text('marka_yok'.tr)
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: state.supplier.brands.list.map((item) {
                              return Card(
                                elevation: 5,
                                child: CircleAvatar(
                                    radius: 60,
                                    child: MyCachedNetworkImage(
                                      imageurl: item.image,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                  Divider(),
                  Tile(
                    title: 'provider_phone'.tr,
                    trailing: state.supplier.phone,
                  ),
                  Divider(),
                  Tile(
                    title: 'provider_website'.tr,
                    trailing: state.supplier.website,
                  ),
                  Divider(),
                  Tile(
                    title: 'register_address'.tr,
                    trailing: state.supplier.address,
                  ),
                  Divider(),
                  Tile(
                    title: 'provider_preview'.tr,
                    trailing: state.supplier.preview.toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "provider_products".tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  GridProducts(
                    products: state.supplier.products.list,
                  ),
                ],
              ),
            ),
          );
  }
}
