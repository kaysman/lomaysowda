import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CatalogContainer extends StatelessWidget {
  const CatalogContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder:
          (BuildContext context, final MyProvider myProvider, Widget child) {
        return Wrap(
          children: myProvider.vipProducts.map((product) {
            return ProductContainer(product: product);
          }).toList(),
        );
      },
    );
  }
}

class ProductContainer extends StatelessWidget {
  final Product product;
  const ProductContainer({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('${product.name_tm}');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(id: product.id)));
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFfbfbfb),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[200],
                  period: Duration(milliseconds: 4000),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                ),
                fit: BoxFit.cover,
                // errorWidget: (context, url, error) => Image.asset(
                //   'assets/bag_10.png',
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Text(
              '${product.name_tm}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
