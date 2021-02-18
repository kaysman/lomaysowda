import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/home/components/vipCatalog.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';

class AllCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
    if (myProvider.allProducts == null) {
      return FutureBuilder<List<Product>>(
        future: myProvider.getAllProducts(
            api: 'http://lomaysowda.com.tm/api/all-products?page=1'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return AllCatalogContainer();
          } else {
            return CatalogShimmerEffect();
          }
        },
      );
    }
    return AllCatalogContainer();
  }
}

class AllCatalogContainer extends StatefulWidget {
  @override
  _AllCatalogContainerState createState() => _AllCatalogContainerState();
}

class _AllCatalogContainerState extends State<AllCatalogContainer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.1;
    final double itemWidth = size.width / 2;

    return Consumer<MyProvider>(
      builder:
          (BuildContext context, final MyProvider myProvider, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisSpacing: 10,
            children: myProvider.allProducts
                .map(
                  (item) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(id: item.id)),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      margin: EdgeInsets.all(6.0),
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
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: CachedNetworkImage(
                              imageUrl: item.image,
                              placeholder: (context, url) => Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              fit: BoxFit.cover,
                              // errorWidget: (context, url, error) => Image.asset(
                              //   'assets/bag_10.png',
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              item.getName('tk'),
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
        );
      },
    );
  }
}
