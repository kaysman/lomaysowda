import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/product_detail/productDetail.dart';
import 'package:provider/provider.dart';

import '../../constaints.dart';
import '../../utils.dart';

class CategoryResult extends StatefulWidget {
  final int catId;
  final String catName;
  const CategoryResult({Key key, this.catId, this.catName}) : super(key: key);

  @override
  _CategoryResultState createState() => _CategoryResultState();
}

class _CategoryResultState extends State<CategoryResult> {
  MyProvider myProvider;
  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: myProvider.getCategoryResult(id: widget.catId),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return CategoriesResult(catName: widget.catName);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError &&
              snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.sentiment_dissatisfied),
                  Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 8.0),
                  ),
                  FlatButton(
                    child: Text("Retry"),
                    onPressed: () {},
                  )
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_neutral),
                Text("Waiting on things to start...")
              ],
            );
          }
          return Container();
        });
  }
}

class CategoriesResult extends StatelessWidget {
  final String catName;

  const CategoriesResult({Key key, @required this.catName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final delegate = S.of(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.1;
    final double itemWidth = size.width / 2;
    return Consumer<MyProvider>(builder: (_, myProvider, child) {
      return Scaffold(
        appBar: homeAppBar(context, title: delegate.categories),
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        child: Center(
                          child: Text(
                            catName,
                            style: kProductNameTextStyle,
                          ),
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: (itemWidth / itemHeight),
                        mainAxisSpacing: 10,
                        children: myProvider.categoryResult
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
                                          item.name_tm,
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
