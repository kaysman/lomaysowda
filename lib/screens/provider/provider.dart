import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';
import 'package:lomaysowdamuckup/utils.dart';

import '../../constaints.dart';

class ProviderGet extends StatefulWidget {
  final int id;

  const ProviderGet({Key key, this.id}) : super(key: key);

  @override
  _ProviderGetState createState() => _ProviderGetState();
}

class _ProviderGetState extends State<ProviderGet> {
  MyProvider myProvider;

  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myProvider.getProductProvider(id: widget.id),
      builder: (_, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ProviderBrandsProducts();
        } else {
          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class ProviderBrandsProducts extends StatefulWidget {
  @override
  _ProviderBrandsProductsState createState() => _ProviderBrandsProductsState();
}

class _ProviderBrandsProductsState extends State<ProviderBrandsProducts> {
  checkImageExtension(myProvider, url) {
    if (url.substring(url.length - 3, url.length) == 'svg') {
      return Image.asset('assets/no_photo.png');
    } else {
      return NetworkImage(
        myProvider.productDetail.provider_image,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.1;
    final double itemWidth = size.width / 2;
    return Consumer<MyProvider>(builder: (_, myProvider, child) {
      return Scaffold(
        appBar: homeAppBar(context, title: 'Satyjy'),
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 20),
                        child: CachedNetworkImage(
                          imageUrl: myProvider.productDetail.provider_image,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              checkImageExtension(myProvider,
                                  myProvider.productDetail.provider_image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          myProvider.productProvider.name,
                          style: kProductNameTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${myProvider.productProvider.preview} görlen",
                          style: kProductDataTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        child: Text(
                          "Markalar",
                          style: kProductNameTextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                      myProvider.productProvider.brands.length == 0
                          ? Text('')
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: myProvider.productProvider.brands
                                    .map((item) {
                                  return Card(
                                    elevation: 5,
                                    child: CircleAvatar(
                                      radius: 60,
                                      child: CachedNetworkImage(
                                        imageUrl: item.image,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                      Divider(),
                      Tile(
                        title: 'Telefon:',
                        trailing: myProvider.productProvider.phone,
                      ),
                      Divider(),
                      Tile(
                        title: 'Web sahypasy:',
                        trailing: myProvider.productProvider.website,
                      ),
                      Divider(),
                      Tile(
                        title: 'Salgy:',
                        trailing: myProvider.productProvider.address,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 25, 8, 10),
                        child: Center(
                          child: Text(
                            "Satyjynyñ harytlary",
                            style: kProductNameTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                      //
                      GridView.count(
                        shrinkWrap: true,
                        physics: new NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: (itemWidth / itemHeight),
                        mainAxisSpacing: 10,
                        children: myProvider.productProvider.products
                            .map(
                              (item) => InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ProductDetailsScreen(id: item.id)),
                                  );
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: CachedNetworkImage(
                                          imageUrl: item.image,
                                          placeholder: (context, url) =>
                                              Container(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            child: Image.asset(
                                              'assets/no_photo.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Text(
                                          '${item.name_tm}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 11,
                                              fontFamily: 'Montserrat-Bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class Tile extends StatelessWidget {
  final String title;
  final dynamic trailing;

  const Tile({Key key, @required this.title, @required this.trailing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(title, style: kProductDataTextStyle)),
          Spacer(),
          Expanded(
              flex: 4,
              child: Text(trailing == null ? '' : trailing,
                  style: kProviderDataTextStyle)),
        ],
      ),
    );
  }
}
