import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';

class SearchBar extends SearchDelegate {
  SearchBar({
    @required String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = ThemeData(
      primaryColor: kPrimaryColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.headline6,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // searchProducts
  @override
  Widget buildResults(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.1;
    final double itemWidth = size.width / 2;
    return Container(
      child: FutureBuilder<List<Product>>(
        future: Provider.of<MyProvider>(context, listen: false)
            .searchProducts(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else if (snapshot.data.length == 0) {
            return Column(
              children: <Widget>[
                Text(
                  "Haryt tapylmady :(",
                ),
              ],
            );
          } else {
            var results = snapshot.data;
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              mainAxisSpacing: 10,
              children: results
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
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyProvider providers = Provider.of<MyProvider>(context, listen: false);
    List<Product> trends = providers.trandProducts;
    List<String> products = providers.trandProducts
        .map((product) => product.getName('tk'))
        .toList();
    final List<String> suggestionList = query.isEmpty
        ? products
        : products.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(
                    id: trends[index].id,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl: trends[index].image,
                  placeholder: (context, url) => Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  fit: BoxFit.cover,
                  // errorWidget: (context, url, error) => Image.asset(
                  //   'assets/bag_10.png',
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              title: Text(suggestionList[index]),
            ),
          );
        });
  }
}
