import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/home/components/vipCatalog.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';

import '../../../constaints.dart';

class TrandCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
    if (myProvider.trandProducts == null) {
      return FutureBuilder<List<Product>>(
        future: myProvider.getTrandProducts(api: 'trand-products'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return TrandCatalogContainer();
          } else {
            return TrandCatalogShimmerEffect();
          }
        },
      );
    } else {
      return TrandCatalogContainer();
    }
  }
}

class TrandCatalogContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder:
          (BuildContext context, final MyProvider myProvider, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: myProvider.trandProducts
                .map(
                  (item) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(id: item.id)),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.14,
                              width: MediaQuery.of(context).size.height * 0.15,
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                                fit: BoxFit.cover,
                                // errorWidget: (context, url, error) => Image.asset(
                                //   'assets/bag_10.png',
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              item.getName('tk'),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
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
        );
      },
    );
  }
}

class TrandCatalogShimmerEffect extends StatelessWidget {
  const TrandCatalogShimmerEffect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
