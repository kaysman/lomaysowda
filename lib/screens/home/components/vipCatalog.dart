import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class VipCatalog extends StatefulWidget {
  @override
  _VipCatalogState createState() => _VipCatalogState();
}

class _VipCatalogState extends State<VipCatalog> {
  MyProvider myProvider;

  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (myProvider.vipProducts == null) {
      return FutureBuilder<List<Product>>(
        future: myProvider.getVipProducts(api: 'vip-products'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return VipCatalogContainer();
          } else {
            return CatalogShimmerEffect();
          }
        },
      );
    } else {
      return VipCatalogContainer();
    }
  }
}

class VipCatalogContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var lang = Provider.of<MyProvider>(context, listen: false).locale;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Consumer<MyProvider>(
      builder:
          (BuildContext context, final MyProvider myProvider, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            children: myProvider.vipProducts
                .map(
                  (item) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(id: item.id)),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.15,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                item.getName(lang),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 11,
                                    fontFamily: 'Montserrat-Bold'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class CatalogShimmerEffect extends StatelessWidget {
  const CatalogShimmerEffect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
          ],
        ),
      ],
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Card(
        elevation: 1,
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
