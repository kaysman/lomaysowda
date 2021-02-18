import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:provider/provider.dart';
import '../../../../constaints.dart';
import 'my_product.dart';

class UserProducts extends StatefulWidget {
  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  @override
  void initState() {
    super.initState();
    getUserProducts();
  }

  Future getUserProducts() async {
    Session session = Provider.of<Session>(context, listen: false);
    await session.getUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Consumer<Session>(
        builder: (BuildContext context, Session session, Widget widget) {
      return session.userProducts == null
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: homeAppBar(context, title: delegate.my_products),
              body: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.05,
                          padding: EdgeInsets.only(left: 6.0),
                          child: FlatButton(
                            color: kPrimaryColor.withOpacity(0.8),
                            child: Text(
                              'Haryt gos',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/add_product'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      physics: NeverScrollableScrollPhysics(),
                      children: session.userProducts.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MyProductPage(id: item.id)));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.35,
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: item.image,
                                      placeholder: (context, url) => Container(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          item.name_tm,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                            fontFamily: 'Montserrat-Regular',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.preview,
                                            size: 14, color: Colors.black38),
                                        Text(
                                          ' ${item.id}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
